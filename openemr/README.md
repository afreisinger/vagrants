# OpenEMR


[OpenEMR](https://open-emr.org) is a Free and Open Source electronic health records and medical practice management application. It features fully integrated electronic health records, practice management, scheduling, electronic billing, internationalization, free support, a vibrant community, and a whole lot more. It runs on Windows, Linux, Mac OS X, and many other platforms.

**Contenido**
1. [TL;DR](#tldr)
1. [Enabling HostUpdater in Vagrant](#enabling-hostupdater-in-vagrant)
2. [LAMP environment in Vagrant ](#lamp-environment-in-vagrant)
3. [OpenEMR](#openemr-1)


## TL;DR
1. VirtualBox, Vagrant and HostUpdater plug-in are installed.
2. Clone this repo and run

```
	git clone https://github.com/afreisinger/vagrants.git
	cd openemr
	vagrant up
```

3. Open your browser

## Check LAMP environment
```
	http://test.local.com
	http://test.local.com/phpinfo.php
	http://test.local.com/db.php
```


## Setup OpenEMR
```
	http://openemr.local.com
```

## Enabling HostUpdater in Vagrant

1. Install the vagrant-hostsupdater plugin:

```
vagrant plugin install vagrant-hostsupdater --plugin-version=1.0.2
Installing the 'vagrant-hostsupdater' plugin. This can take a few minutes...
Installed the plugin 'vagrant-hostsupdater (1.0.2)'!
```
[Read more](https://github.com/Varying-Vagrant-Vagrants/VVV/issues/1458#issuecomment-378094333)


## LAMP environment in Vagrant

That's it! In relatively little time you've created a nice boilerplate that you can use in any PHP/MySQL project and you've now got a basic understanding on how to easily set up a local, re-usable environment. 
Ewald Vanderveken created a [repository on GitHub](https://github.com/eekes/blog-vagrant-1) containing the full example.

Article from Ewald Vanderveken [article](https://www.ewaldvanderveken.dev/setting-up-a-lamp-development-environment-in-vagrant/) about setting up a LAMP environment in Vagrant.


## OpenEMR Project
<img src="icon.png" width="50" height="50" />

![Syntax Status](https://github.com/openemr/openemr/workflows/Syntax/badge.svg?branch=rel-700)
![Styling Status](https://github.com/openemr/openemr/workflows/Styling/badge.svg?branch=rel-700)
![Testing Status](https://github.com/openemr/openemr/workflows/Test/badge.svg?branch=rel-700)

[![Backers on Open Collective](https://opencollective.com/openemr/backers/badge.svg)](#backers) [![Sponsors on Open Collective](https://opencollective.com/openemr/sponsors/badge.svg)](#sponsors)


[OpenEMR](https://open-emr.org) is a Free and Open Source electronic health records and medical practice management application. It features fully integrated electronic health records, practice management, scheduling, electronic billing, internationalization, free support, a vibrant community, and a whole lot more. It runs on Windows, Linux, Mac OS X, and many other platforms.

### Contributing

OpenEMR is a leader in healthcare open source software and comprises a large and diverse community of software developers, medical providers and educators with a very healthy mix of both volunteers and professionals. [Join us and learn how to start contributing today!](https://open-emr.org/wiki/index.php/FAQ#How_do_I_begin_to_volunteer_for_the_OpenEMR_project.3F)

> Already comfortable with git? Check out [CONTRIBUTING.md](CONTRIBUTING.md) for quick setup instructions and requirements for contributing to OpenEMR by resolving a bug or adding an awesome feature 😊.

### Support

Community and Professional support can be found [here](https://open-emr.org/wiki/index.php/OpenEMR_Support_Guide).

Extensive documentation and forums can be found on the [OpenEMR website](https://open-emr.org) that can help you to become more familiar about the project 📖.

### Reporting Issues and Bugs

Report these on the [Issue Tracker](https://github.com/openemr/openemr/issues). If you are unsure if it is an issue/bug, then always feel free to use the [Forum](https://community.open-emr.org/) and [Chat](https://www.open-emr.org/chat/) to discuss about the issue 🪲.

### Reporting Security Vulnerabilities

Check out [SECURITY.md](html/openemr/.github/SECURITY.md)

### API

Check out [API_README.md](html/openemr/API_README.md)

### Docker

Check out [DOCKER_README.md](html/openemr/DOCKER_README.md)

### FHIR

Check out [FHIR_README.md](html/openemr/FHIR_README.md)

### For Developers

If using OpenEMR directly from the code repository, then the following commands will build OpenEMR (Node.js version 16.* is required) :

```shell
composer install --no-dev
npm install
npm run build
composer dump-autoload -o
```

### Contributors

This project exists thanks to all the people who have contributed. [[Contribute]](html/openemr/CONTRIBUTING.md).
<a href="https://github.com/openemr/openemr/graphs/contributors"><img src="https://opencollective.com/openemr/contributors.svg?width=890" /></a>


### Sponsors

Thanks to our [2015 Edition Major Sponsors](https://www.open-emr.org/wiki/index.php/OpenEMR_Certification_Stage_III_Meaningful_Use#Major_sponsors)!


### License

[GNU GPL](LICENSE)
