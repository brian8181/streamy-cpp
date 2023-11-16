[1mdiff --git a/.vscode/launch.json b/.vscode/launch.json[m
[1mindex 1fe742f..9220fe2 100644[m
[1m--- a/.vscode/launch.json[m
[1m+++ b/.vscode/launch.json[m
[36m@@ -24,6 +24,27 @@[m
             ],[m
             "preLaunchTask": "MAKE DEBUGGDB",[m
             "miDebuggerPath": "/usr/bin/gdb"[m
[32m+[m[32m        },[m
[32m+[m[32m        {[m
[32m+[m[32m            "name": "dubug app",[m
[32m+[m[32m            "type": "cppdbg",[m
[32m+[m[32m            "request": "launch",[m
[32m+[m[32m            "program": "${workspaceFolder}/build/streamy_app_a",[m
[32m+[m[32m            "args": [],[m
[32m+[m[32m            "stopAtEntry": false,[m
[32m+[m[32m            "cwd": "${workspaceFolder}",[m
[32m+[m[32m            "environment": [],[m
[32m+[m[32m            "externalConsole": false,[m
[32m+[m[32m            "MIMode": "gdb",[m
[32m+[m[32m            "setupCommands": [[m
[32m+[m[32m                {[m
[32m+[m[32m                    "description": "Enable pretty-printing for gdb",[m
[32m+[m[32m                    "text": "-enable-pretty-printing",[m
[32m+[m[32m                    "ignoreFailures": true[m
[32m+[m[32m                }[m
[32m+[m[32m            ],[m
[32m+[m[32m            "preLaunchTask": "MAKE DEBUGGDB",[m
[32m+[m[32m            "miDebuggerPath": "/usr/bin/gdb"[m
         }[m
   ][m
 }[m
[1mdiff --git a/.vscode/tasks.json b/.vscode/tasks.json[m
[1mindex a58f253..be3ce19 100644[m
[1m--- a/.vscode/tasks.json[m
[1m+++ b/.vscode/tasks.json[m
[36m@@ -3,7 +3,7 @@[m
         {[m
             "label": "MAKE DEBUGGDB",[m
             "type": "shell",[m
[31m-            "command": "make -f ${fileDirname}/Makefile",[m
[32m+[m[32m            "command": "make -f ${workspaceFolder}/Makefile",[m
             "problemMatcher": [[m
                 "$gcc"[m
             ],[m
[1mdiff --git a/src/streamy.cpp b/src/streamy.cpp[m
[1mindex 0c60436..507e924 100644[m
[1m--- a/src/streamy.cpp[m
[1m+++ b/src/streamy.cpp[m
[36m@@ -283,31 +283,6 @@[m [mstring& streamy::trim(std::string &s)[m
     return s;[m
 }[m
 [m
[31m-// std::string& streamy::ltrim(std::string &s)[m
[31m-// {[m
[31m-//     auto it = std::find_if(s.begin(), s.end(),[m
[31m-//                     [](char c) {[m
[31m-//                         return !std::isspace<char>(c, std::locale::classic());[m
[31m-//                     });[m
[31m-//     s.erase(s.begin(), it);[m
[31m-//     return s;[m
[31m-// }[m
[31m-[m
[31m-// std::string& streamy::rtrim(std::string &s)[m
[31m-// {[m
[31m-//     auto it = std::find_if(s.rbegin(), s.rend(),[m
[31m-//                     [](char c) {[m
[31m-//                         return !std::isspace<char>(c, std::locale::classic());[m
[31m-//                     });[m
[31m-//     s.erase(it.base(), s.end());[m
[31m-//     return s;[m
[31m-// }[m
[31m-[m
[31m-// std::string& streamy::trim(std::string &s)[m
[31m-// {[m
[31m-//     return ltrim(rtrim(s));[m
[31m-// }[m
[31m-[m
 std::string streamy::lex(const string& tmpl)[m
 {[m
     string path = template_dir + "/" + tmpl;[m
