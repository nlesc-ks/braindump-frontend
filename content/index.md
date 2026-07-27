---
title: Knowledge base
tags:
  - meta
---

## What is this?
This is a prototype for a knowledge base for the [Netherlands eScience Center](https://esciencecenter.nl).
## How does this work?
### In a nutshell
We render a website from a collection of markdown files. The files can link each other using Wiki-style links (the ones with the `[[<filename>]]` structure). The website is searchable, and additionally generates a graph map and a list of incoming and outcoming links.

All of this will be familiar to Obsidian users. Actually, the `./contents` folder can be opened and managed locally as an Obsidian vault.
### For more details
This website is made with Quartz. See the [documentation](https://quartz.jzhao.xyz) for how to get started!
## Why?
Our previous approaches to information management proved to be insufficient. The main problems we identified are poor searchability and complicated editing.

The advantages of this approach are manifold:

- We don't need a folder structure. Information is navigated via links, graphs and the search bar
- We don't need a detailed taxonomy of tags
- The website can be updated by anyone in a straightforward way via pull requests to GitHub
## Information for authors
Want to make an edition? Feel free to open a pull request at [our repo](https://github.com/PabRod/quartz-test).

## Test
[[Automatic differentiation]]