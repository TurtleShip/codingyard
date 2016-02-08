# Overview

This document contains my development style guide. Is it opinionated? Of course. But I am willing to lean the other way otherwise if you suggest a better approach.


### How css is structured.

I tried to follow [SMACSS guideline](https://smacss.com/). My css is structured as below

#### Base

Contains rules that apply to selectors, such as ```body```, ```form```, and ```a```.

> A Base rule is applied to an element using an element selector, a descendent selector, or a child selector, along with any pseudo-classes. It doesn’t include any class or ID selectors. It is defining the default styling for how that element should look in all occurrences on the page. --- <cite>[SMACSS](https://smacss.com/)</cite>

#### Layout

Contains the biggest layout components of my website, such as ```#header```, ```#main-content```, and ```#footer```.

> CSS, by its very nature, is used to lay elements out on the page. However, there is a distinction between layouts dictating the major and minor components of a page. The minor components—such as a callout, or login form, or a navigation item—sit within the scope of major components such as a header or footer. The minor components are referred to as Modules, and the major components are referred to as Layout styles. --- <cite>[SMACSS](https://smacss.com/)</cite>

#### Module

Contains small layout components of my website, such as ```.full-form```. When defining the rule set for a module, **avoid using IDs** and element selectors, sticking only to class names.

> A Module is a more discrete component of the page. It is your navigation bars and your carousels and your dialogs and your widgets and so on. This is the meat of the page. Modules sit inside Layout components. Modules can sometimes sit within other Modules, too. Each Module should be designed to exist as a standalone component. In doing so, the page will be more flexible. If done right, Modules can easily be moved to different parts of the layout without breaking. --- <cite>[SMACSS](https://smacss.com/)</cite>
