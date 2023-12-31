#
# Find the MySQL client includes and library
# 

# This module defines
# MYSQL_INCLUDE_DIR, where to find mysql.h
# MYSQL_LIBRARIES, the libraries to link against to connect to MySQL
# MYSQL_FOUND, if false, you cannot build anything that requires MySQL.

# also defined, but not for general use are
# MYSQL_LIBRARY, where to find the MySQL library.

set( MYSQL_FOUND 0 )

if( UNIX )
  set(MYSQL_CONFIG_PREFER_PATH "$ENV{MYSQL_HOME}/bin" CACHE FILEPATH
    "preferred path to MySQL (mysql_config)"
  )

  find_program(MYSQL_CONFIG mysql_config
    ${MYSQL_CONFIG_PREFER_PATH}
    /usr/local/mysql/bin/
    /usr/local/bin/
    /usr/bin/
  )

  if( MYSQL_CONFIG )
    message(STATUS "Using mysql-config: ${MYSQL_CONFIG}")
    # set INCLUDE_DIR
    exec_program(${MYSQL_CONFIG}
      ARGS --include
      OUTPUT_VARIABLE MY_TMP
    )

    string(REGEX REPLACE "-I([^ ]*)( .*)?" "\\1" MY_TMP "${MY_TMP}")
    set(MYSQL_ADD_INCLUDE_PATH ${MY_TMP} CACHE FILEPATH INTERNAL)
    #message("[DEBUG] MYSQL ADD_INCLUDE_PATH : ${MYSQL_ADD_INCLUDE_PATH}")
    # set LIBRARY_DIR
    exec_program(${MYSQL_CONFIG}
      ARGS --libs_r
      OUTPUT_VARIABLE MY_TMP
    )
    set(MYSQL_ADD_LIBRARIES "")
    string(REGEX MATCHALL "-l[^ ]*" MYSQL_LIB_LIST "${MY_TMP}")
    foreach(LIB ${MYSQL_LIB_LIST})
      string(REGEX REPLACE "[ ]*-l([^ ]*)" "\\1" LIB "${LIB}")
      list(APPEND MYSQL_ADD_LIBRARIES "${LIB}")
      #message("[DEBUG] MYSQL ADD_LIBRARIES : ${MYSQL_ADD_LIBRARIES}")
    endforeach(LIB ${MYSQL_LIB_LIST})

    set(MYSQL_ADD_LIBRARIES_PATH "")
    string(REGEX MATCHALL "-L[^ ]*" MYSQL_LIBDIR_LIST "${MY_TMP}")
    foreach(LIB ${MYSQL_LIBDIR_LIST})
      string(REGEX REPLACE "[ ]*-L([^ ]*)" "\\1" LIB "${LIB}")
      list(APPEND MYSQL_ADD_LIBRARIES_PATH "${LIB}")
      #message("[DEBUG] MYSQL ADD_LIBRARIES_PATH : ${MYSQL_ADD_LIBRARIES_PATH}")
    endforeach(LIB ${MYSQL_LIBS})

  else( MYSQL_CONFIG )
    set(MYSQL_ADD_LIBRARIES "")
    list(APPEND MYSQL_ADD_LIBRARIES "mysqlclient_r")
  endif( MYSQL_CONFIG )
endif( UNIX )

if( WIN32 )
  # read environment variables and change \ to /
  SET(SYSTEM_DRIVE $ENV{SystemDrive})
  
  if (PLATFORM EQUAL 64)
    SET(PROGRAM_FILES_32 "$ENV{ProgramFiles} (x86)")
    SET(PROGRAM_FILES_64 "$ENV{ProgramW6432}")
  else (PLATFORM EQUAL 64)
    SET(PROGRAM_FILES_32 "$ENV{ProgramFiles}")
    SET(PROGRAM_FILES_64 "$ENV{ProgramFiles}")
  endif (PLATFORM EQUAL 64)

  STRING(REPLACE "\\" "/" PROGRAM_FILES_32 ${PROGRAM_FILES_32})
  STRING(REPLACE "\\" "/" PROGRAM_FILES_64 ${PROGRAM_FILES_64})
endif ( WIN32 )

find_path(MYSQL_INCLUDE_DIR
  NAMES
    mysql.h
  PATHS
    ${MYSQL_ADD_INCLUDE_PATH}
    /usr/include
    /usr/include/mysql
    /usr/include/mariadb
    /usr/local/include
    /usr/local/include/mysql
    /usr/local/mysql/include
    "${PROGRAM_FILES_64}/MySQL/MySQL Server 5.7/include"
    "${PROGRAM_FILES_64}/MySQL/MySQL Server 5.6/include"
    "${PROGRAM_FILES_64}/MySQL/include"
    "${PROGRAM_FILES_32}/MySQL/MySQL Server 5.7/include"
    "${PROGRAM_FILES_32}/MySQL/MySQL Server 5.6/include"
    "${PROGRAM_FILES_32}/MySQL/include"
    "${SYSTEM_DRIVE}/MySQL/include"
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MySQL AB\\MySQL Server 5.7;Location]/include"
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MySQL AB\\MySQL Server 5.6;Location]/include"
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MySQL AB\\MySQL Server 5.7;Location]/include"
    "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MySQL AB\\MySQL Server 5.6;Location]/include"
    "${PROGRAM_FILES_32}/MariaDB 10.5/include/mysql"
    "${PROGRAM_FILES_32}/MariaDB 10.4/include/mysql"
    "${PROGRAM_FILES_64}/MariaDB 10.5/include/mysql"
    "${PROGRAM_FILES_64}/MariaDB 10.4/include/mysql"
  DOC
    "Specify the directory containing mysql.h."
)

if( UNIX )
  foreach(LIB ${MYSQL_ADD_LIBRARIES})
    find_library( MYSQL_LIBRARY 
      NAMES
        mysql libmysql ${LIB}
      PATHS
        ${MYSQL_ADD_LIBRARIES_PATH}
        /usr/lib
        /usr/lib/mysql
        /usr/local/lib
        /usr/local/lib/mysql
        /usr/local/mysql/lib
      DOC "Specify the location of the mysql library here."
    )
  endforeach(LIB ${MYSQL_ADD_LIBRARY})
endif( UNIX )

if( WIN32 )
  find_library( MYSQL_LIBRARY 
    NAMES
      libmysql
    PATHS
      ${MYSQL_ADD_LIBRARIES_PATH}
      "${PROGRAM_FILES_32}/MySQL/MySQL Server 5.7/lib"
      "${PROGRAM_FILES_32}/MySQL/MySQL Server 5.6/lib"
      "${PROGRAM_FILES_64}/MySQL/MySQL Server 5.7/lib"
      "${PROGRAM_FILES_64}/MySQL/MySQL Server 5.6/lib"
      "${SYSTEM_DRIVE}/MySQL/lib"
      "${SYSTEM_DRIVE}/MySQL/lib"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MySQL AB\\MySQL Server 5.7;Location]/lib"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\MySQL AB\\MySQL Server 5.6;Location]/lib"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MySQL AB\\MySQL Server 5.7;Location]/lib"
      "[HKEY_LOCAL_MACHINE\\SOFTWARE\\Wow6432Node\\MySQL AB\\MySQL Server 5.6;Location]/lib"
      "${PROGRAM_FILES_32}/MariaDB 10.5/lib"
      "${PROGRAM_FILES_32}/MariaDB 10.4/lib"
      "${PROGRAM_FILES_64}/MariaDB 10.5/lib"
      "${PROGRAM_FILES_64}/MariaDB 10.4/lib"
    DOC "Specify the location of the mysql library here."
  )
endif( WIN32 )

# On Windows you typically don't need to include any extra libraries
# to build MYSQL stuff.

if( NOT WIN32 )
  find_library( MYSQL_EXTRA_LIBRARIES
    NAMES
      z zlib
    PATHS
      /usr/lib
      /usr/local/lib
    DOC
      "if more libraries are necessary to link in a MySQL client (typically zlib), specify them here."
  )
else( NOT WIN32 )
  set( MYSQL_EXTRA_LIBRARIES "" )
endif( NOT WIN32 )

if( MYSQL_LIBRARY )
  if( MYSQL_INCLUDE_DIR )
    set( MYSQL_FOUND 1 )
    message(STATUS "Found MySQL library: ${MYSQL_LIBRARY}")
    message(STATUS "Found MySQL headers: ${MYSQL_INCLUDE_DIR}")
    
    if (WIN32)
        get_filename_component(MYSQL_LIB_PATH ${MYSQL_LIBRARY} PATH)
        get_filename_component(MYSQL_LIB_NAME ${MYSQL_LIBRARY} NAME_WE)
        set(MYSQL_DLL_LIBRARY "${MYSQL_LIB_PATH}/${MYSQL_LIB_NAME}.dll" CACHE INTERNAL "")
        install(FILES ${MYSQL_DLL_LIBRARY} DESTINATION "${CMAKE_INSTALL_PREFIX}")
        
        set (MYSQL_LIB_PATH "${MYSQL_LIB_PARTH}" CACHE INTERNAL "")
        set (MYSQL_LIB_NAME "${MYSQL_LIB_PARTH}" CACHE INTERNAL "")
    endif (WIN32)
  else( MYSQL_INCLUDE_DIR )
    message(FATAL_ERROR "Could not find MySQL headers! Please install the development libraries and headers")
  endif( MYSQL_INCLUDE_DIR )
  mark_as_advanced( MYSQL_FOUND MYSQL_EXTRA_LIBRARIES )
else( MYSQL_LIBRARY )
  message(FATAL_ERROR "Could not find the MySQL libraries! Please install the development libraries and headers")
endif( MYSQL_LIBRARY )
