## yalb - Yet Another (Lua-based) Build tool - EXPERIMENT

yalb aims to be a composable library helping to write build-files in Lua.
It's based initially on Steve Donovan's [lake](https://github.com/stevedonovan/lake).
I want to try and steal the most valuable parts of lake, but remove the
framework-like character of the tool.

### TODOs, goals, notes, ideas

```
TODO: [LATER] steal from stevedonovan's luabuild too
TODO: [LATER] create 1-file amalgm of the C parts for easy compilation

GOAL: - steal the good parts/knowledge from stevedonovan's lake
        - c, c99, cpp, ...?
        - dependencies resolution?
          - timestamp-based
          - should allow custom testers too
        - windows gui flags?
        - pkg-config access?
          -> would be nice to try more here, including what's done with 'needs' in lake
GOAL: - make the library "composable", not a framework
GOAL: - at first, start with using LFS etc (lake.exe)
GOAL: - facilitate importing of subprojects yalb-files (e.g. libpng for SILE)
        - importable
        - built in their own dirs (?)
        - [LATER] also make-based subprojects etc.
GOAL: - by default, try to put intermediate (and final?) files in separate working dir
        - [LATER] based on settings & files & dates (/hashes?) hash?

TODO: CC redefinition possibility in lake is nice (i.e. `lake CC=/path/to/my/gcc`)
```


Released under the MIT/X11 licence,  
Steve Donovan, 2010-2013  
Mateusz Czapliński 2016

