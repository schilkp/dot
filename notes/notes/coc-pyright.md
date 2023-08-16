=== coc-pyright ===

Handles everything python3 for CoC.

= Project Root = 

Python only allows basic 'import some_other_file' statements at the root of a project
without other accommodations.

CoC/pyright will use the git-repo root as the root of the project, so there will be issues
if the script is kept in a subdirecroty.

I added .coc_root to coc.preferences.rootPatterns in coc-settings.json.

Now, placing a .coc_root file in a folder will make CoC/pyright use that folder
instead of a parent git-repo.
