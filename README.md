# dataform.nvim

Dataform is a data transformation tool that was acquired by Google and has been integrated
into BigQuery.

dataform/core contains the core functionalities and a CLI interface for running all the
commands.

but the GCP Console offers some quality of life resources by regularly compiling queries
and running dry-run to validate SQL.

The idea of this project is to offer similiar functionalities for local development
with neovim.


## What it should do:

• Allow me to call a lua cmd or a keymap and:

    - compile the dataform project

    - parse compilation results for errors

    - if the compilation is valid:
        - open a side buffer with the compiled result.
        - dry-run current file agains bigquery.
        - highlight any errors on the compile result buffer.

    - if compilation fails:
        - highlight lines around error on current file

    - There should be two distinct phases: compile and validate.
        - I should be able to trigger any or both.
        - A validate call will always use the latest compilation saved.
        - A compile call will always be saved as a new compilation.

• Allow me to navigate to reference file

    - parse all the ref around the cursor.

    - if ref has missing keys, fill with deafult mapping.
    - search for node in compile graph.

    - if buffer for file already exist, open that.
        - else start a buffer for the file and attach to current window.

• Eventually include better features like formatting and testing locally with duckdb...

