Conferences DB
==============

A small ruby on rails applications that lists relevant research conferences where you might want to submit your paper. 

## Features

* Adding, editing and listing conferences
* Sorting by deadline (abstract or fullpaper - whatever comes first)
* Archive of conferences with in the past
* iCalendar support for all conferences or just single events
* Tag support (search by tags, tag cloud)
* Show the conference on Open Street Maps
* Add collegues who also plan to submit, were accepted, attend the conference
* "I feel lucky to publish" looking for the next conference open to take submissions.

## Requirements

* Rails 4.1
* bundler gem

## Installation

On *Unix* Systems (assuming you have rvm installed): ```bundle install``` should install all the ruby requirements. Also Rails 4.1 requires a ```config/secrets.yml``` which contains a secret key. You can generate a new key by using ```rake secret```

To customize/brand the conference app just create/edit ```config/config.yaml``` and change ```institute_name``` to your institute
