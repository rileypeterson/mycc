# My Cookie Cutter

Starting place for a stack which includes Docker, NGINX, Django/FastAPI, and more...

# Requirements
...

# TODO
https://cookiecutter.readthedocs.io/en/2.1.1/advanced/replay.html
Hook for gitignored files...https://cookiecutter.readthedocs.io/en/2.1.1/advanced/hooks.html

# Favicon generator
https://favicon.io/

# Handling Unrendered Files
* The following files aren't rendered and django templates don't play nicely with cookiecutter:
    ```
      "_copy_without_render": [
        "{{cookiecutter.project_slug}}/pages/templates/pages/*.html"
      ]
    ```
* Therefore, just use the following `[[[[cookiecutter.project_name]]]]` (no spaces) within those files
* It'll be rendered by the `post_gen_project.py` hook
* For now only `cookiecutter.project_name` will be recognized, but it would be straight forward to add more.