USING FOUNDATION
================

**_This package uses FoundationPress as a base template when run._**

Stylesheet Folder Structure
---------------------------

**style.css**: Do not worry about this file. It's required by WordPress. All styling are handled in the Sass files described below. The name is updated automatically when GRUNTMAKER9000 is run.

**scss/app.scss**: STRUCTURE FILE:- imports all other scss files in order.

**scss/config/_variables.scss**: Enter your SASS variables in here.

**scss/config/_colors.scss**: Enter your site's general colour scheme here.

**scss/config/_settings.scss**: BASE SETTINGS:- Don't touch unless conflicting with design

**scss/site/_structure**: THIS IS WHERE YOU ENTER YOUR CUSTOM CSS/SASS.

**css/app.css**: All Sass files are minified and compiled to this file after grunt is run.
