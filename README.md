# My Cookie Cutter

Starting place for a stack which includes Docker, NGINX, Django/FastAPI, and more...

# Requirements
...

# Favicon generator
https://favicon.io/

# Environment Files
* Environment files are placed here:
  ```
  {{cookiecutter.project_slug}}/config/.dev.env
  {{cookiecutter.project_slug}}/config/.prod.env
  ```
* They're ignored
* If they already exist, they won't be overwritten when generating the cookiecutter
  * This is because Postgres auth won't work if the credentials are overwritten
* See aliases.sh (Doesn't remove these files)

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