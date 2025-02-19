project "GLFW"
    kind "StaticLib"
    language "C"
    staticruntime "On"
    
    targetdir ("bin/" .. outdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outdir .. "/%{prj.name}")
    
    files
    {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h",
        "src/glfw_config.h",
        "src/internal.h",
        "src/platform.h",
        "src/mappings.h",

        "src/egl_context.c",
        "src/osmesa_context.c",
        
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        
        "src/null_platform.h",
        "src/null_init.c",
        "src/null_joystick.h",
        "src/null_joystick.c",
        "src/null_monitor.c",
        "src/null_window.c",
        
        "src/platform.c",
        "src/vulkan.c",
        "src/window.c"
    }

    includedirs
    {
        "%{prj.name}/include",
        "%{prj.name}/src"
    }

filter "system:windows"
    systemversion "latest"
    
    files
    {
        "src/win32_time.h",
        "src/win32_thread.h",
        "src/win32_module.c",
        "src/win32_time.c",
        "src/win32_thread.c",
        
        "src/win32_platform.h",
        "src/win32_joystick.h",
        "src/win32_init.c",
        "src/win32_joystick.c",
        "src/win32_monitor.c",
        "src/win32_window.c",
        "src/wgl_context.c",        
    }    

    defines
    {
        "_GLFW_WIN32",
        "_CRT_SECURE_NO_WARNINGS"        
    }

    links
    {
        "kernel32", 
        "user32",
        "gdi32",
        "advapi32"
    }
    
filter{ "system:windows", "options:GLFW_BUILD_WIN32" }
    defines
    {
        "UNICODE", 
        "_UNICODE"
    }
    
filter "system:linux"
    pic "On"

    systemversion "latest"
    
    files
    {
        -- Time, thread and module code
        "src/posix_time.h",
        "src/posix_thread.h",
        "src/posix_module.c",
        "src/posix_time.c",
        "src/posix_thread.c",        
                
        "src/x11_platform.h",
        "src/xkb_unicode.h",
        "src/x11_init.c",
        "src/x11_monitor.c",
        "src/x11_window.c",
        "src/xkb_unicode.c",
        "src/glx_context.c",
        
        "src/posix_poll.h",
        "src/posix_poll.c",
        "src/linux_joystick.h",
        "src/linux_joystick.c"
    }

    defines
    {
        "_GLFW_X11"
    }

    links
    {
        "pthread", 
        "dl"        
    }
    
filter "configurations:Debug"
    runtime "Debug"
    symbols "On"
    
filter {"system:windows", "configurations:Debug-AS"}
    runtime "Debug"
    symbols "On"
    sanitize { "Address" }        
    flags {"NoRunTimeChecks", "NoIncrementalLink"}
    
filter "configurations:Release"
    runtime "Release"
    optimize "Speed"
    
filter "configurations:Dist"
    runtime "Release"
    optimize "Speed"
    symbols "Off"
        