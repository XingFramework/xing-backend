0.0.17 / 2015-07-07
========
  * Refactor ListDifferenceBuilder/OrderedListDifferenceBuilder to ListBuilder/OrderedListBuilder
  * Name change from ListDifferenceBuilder to ListBuilder
  * Breaking change, LDB now takes 2 arguments instead of 3 and the output of the #build method is an array of AR objects rather than a hash.
  * Remove deprecation on ListDifferenceBuilder
  * Add to CHANGELOG.md

0.0.16 / 2015-06-29
========
  * Fix bug with ListDifferenceBuilder route_to method
  * Add CHANGELOG.md

0.0.15 / 2015-06-26
========
  * include Locator Module properly
  * Fix bug with unwrap links

0.0.14 / 2015-06-26
========
  * Add builder dir
  * Add ListDifferenceBuilder and OrderedListDifference Builder
  * Add deprecation mechanisms for ListDifferenceBuilder
  * Add services/locator.rb
  * Refactor mappers/base.rb
