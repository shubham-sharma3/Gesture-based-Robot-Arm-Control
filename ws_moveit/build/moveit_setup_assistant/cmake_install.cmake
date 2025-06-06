# Install script for directory: /home/rosuser/ros2_ws/ws_moveit/src/moveit2/moveit_setup_assistant/moveit_setup_assistant

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/rosuser/ros2_ws/ws_moveit/install/moveit_setup_assistant")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

# Set default install directory permissions.
if(NOT DEFINED CMAKE_OBJDUMP)
  set(CMAKE_OBJDUMP "/usr/bin/objdump")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant" TYPE EXECUTABLE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/moveit_setup_assistant")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant"
         OLD_RPATH "/home/rosuser/ros2_ws/ws_moveit/install/moveit_setup_srdf_plugins/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_setup_framework/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_visualization/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_robot_interaction/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_planning_interface/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_warehouse/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_core/lib:/opt/ros/humble/lib/aarch64-linux-gnu:/home/rosuser/ros2_ws/ws_moveit/install/srdfdom/lib:/opt/ros/humble/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_move_group/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_planning/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_occupancy_map_monitor/lib:/opt/ros/humble/opt/rviz_ogre_vendor/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/moveit_setup_assistant")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater")
    file(RPATH_CHECK
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater"
         RPATH "")
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant" TYPE EXECUTABLE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/collisions_updater")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater")
    file(RPATH_CHANGE
         FILE "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater"
         OLD_RPATH "/home/rosuser/ros2_ws/ws_moveit/install/moveit_setup_srdf_plugins/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_setup_framework/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_visualization/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_robot_interaction/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_planning_interface/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_warehouse/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_core/lib:/opt/ros/humble/lib/aarch64-linux-gnu:/home/rosuser/ros2_ws/ws_moveit/install/srdfdom/lib:/opt/ros/humble/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_move_group/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_planning/lib:/home/rosuser/ros2_ws/ws_moveit/install/moveit_ros_occupancy_map_monitor/lib:/opt/ros/humble/opt/rviz_ogre_vendor/lib:"
         NEW_RPATH "")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/moveit_setup_assistant/collisions_updater")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/rosuser/ros2_ws/ws_moveit/src/moveit2/moveit_setup_assistant/moveit_setup_assistant/include/")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE DIRECTORY FILES "/home/rosuser/ros2_ws/ws_moveit/src/moveit2/moveit_setup_assistant/moveit_setup_assistant/launch")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE DIRECTORY FILES "/home/rosuser/ros2_ws/ws_moveit/src/moveit2/moveit_setup_assistant/moveit_setup_assistant/resources")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/opt/ros/humble/lib/python3.10/site-packages/ament_package/template/environment_hook/library_path.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/library_path.dsv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ament_index/resource_index/package_run_dependencies" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_index/share/ament_index/resource_index/package_run_dependencies/moveit_setup_assistant")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ament_index/resource_index/parent_prefix_path" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_index/share/ament_index/resource_index/parent_prefix_path/moveit_setup_assistant")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/ament_prefix_path.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/ament_prefix_path.dsv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/opt/ros/humble/share/ament_cmake_core/cmake/environment_hooks/environment/path.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/environment" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/path.dsv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/local_setup.bash")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/local_setup.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/local_setup.zsh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/local_setup.dsv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_environment_hooks/package.dsv")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/ament_index/resource_index/packages" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_index/share/ament_index/resource_index/packages/moveit_setup_assistant")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport.cmake")
    file(DIFFERENT EXPORT_FILE_CHANGED FILES
         "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport.cmake"
         "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/CMakeFiles/Export/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport.cmake")
    if(EXPORT_FILE_CHANGED)
      file(GLOB OLD_CONFIG_FILES "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport-*.cmake")
      if(OLD_CONFIG_FILES)
        message(STATUS "Old export file \"$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport.cmake\" will be replaced.  Removing files [${OLD_CONFIG_FILES}].")
        file(REMOVE ${OLD_CONFIG_FILES})
      endif()
    endif()
  endif()
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/CMakeFiles/Export/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport.cmake")
  if("${CMAKE_INSTALL_CONFIG_NAME}" MATCHES "^([Rr][Ee][Ll][Ee][Aa][Ss][Ee])$")
    file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/CMakeFiles/Export/share/moveit_setup_assistant/cmake/moveit_setup_assistantTargetsExport-release.cmake")
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_export_include_directories/ament_cmake_export_include_directories-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_export_targets/ament_cmake_export_targets-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_export_dependencies/ament_cmake_export_dependencies-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant/cmake" TYPE FILE FILES
    "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_core/moveit_setup_assistantConfig.cmake"
    "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/ament_cmake_core/moveit_setup_assistantConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/moveit_setup_assistant" TYPE FILE FILES "/home/rosuser/ros2_ws/ws_moveit/src/moveit2/moveit_setup_assistant/moveit_setup_assistant/package.xml")
endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/rosuser/ros2_ws/ws_moveit/build/moveit_setup_assistant/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
