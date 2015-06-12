The Xing Framework: Backend
===========================

The Xing Framework is a cutting edge web and mobile development platform by Logical Reality Design, Inc.  It is designed to provide a completely modern (and even somewhat future-proofed) API + SPA web development platform with sensible defaults, solid conventions, and ease of rapid development. Xing uses Rails (4.2) on the backend and AngularJS (1.4) on the frontend.  Most of the problems inherent in getting these two frameworks to talk to each other cleanly have been pre-solved in Xing.

This gem is a Rails Engine that implements the extensions necessary for Rails to function as a Xing back-end API server.

[![Code Climate](https://codeclimate.com/github/LRDesign/xing-backend/badges/gpa.svg)](https://codeclimate.com/github/LRDesign/xing-backend)
[![Test Coverage](https://codeclimate.com/github/LRDesign/xing-backend/badges/coverage.svg)](https://codeclimate.com/github/LRDesign/xing-backend/coverage)
[![Build Status](https://travis-ci.org/LRDesign/xing-backend.svg?branch=master)](https://travis-ci.org/LRDesign/xing-backend)
[![Dependency Status](https://gemnasium.com/LRDesign/xing-backend.svg)](https://gemnasium.com/LRDesign/xing-backend)


Serializers
-----------

TODO:  Subclasses of Xing::Serializers::Base generate hypermedia enabled JSON resources from one or more ActiveModel objects (or other data).


Mappers
-------

TODO:  Subclasses of Xing::Mappers::Base consume incoming hypermedia JSON resources, mapping them to ActiveModel objects for persistence.

Controllers
-----------

TODO: Xing::BaseController contains several helper functions to format correct-to-spec HTTP responses.  In a Xing application, your controllers should subclass Xing::BaseController.

Services
--------

TODO: An assortment of utility classes that perform other functions, including:

  • Translating ActiveModel/ActiveRecord validation errors into a form suitable for transmitting as a hypermedia error resource.
  • Fetching site snapshots from an external server, for SEO purposes.
  • Tree lister 


Authors
-------

Evan Dorn
Hannah Howard
Judson Lester
Patricia Ho

Version
-------

Untagged version, not yet ready for release
