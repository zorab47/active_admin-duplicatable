# Change Log

All notable changes to this project will be documented in this file.

## [Unreleased]

## [0.4.0] - 2018-07-18

### Changed

- Switch from Rail's `before_filter` to `before_action`. The method
  `before_filter` was deprecated in Rails 5.0 and removed in Rails 5.1.

## [0.3.0] - 2017-10-03

### Added

- Allow custom duplication methods in the `:via` option. Rather than always
  calling `#amoeba_dup`, it can be configured to call any method.

## [0.2.0] - 2015-07-23

- Avoid ActiveAdmin `1.0.0.pre1` deprecation warning when `#action_item` isn't
 named, and maintain backward compatibility with older ActiveAdmin versions.

## [0.1.0] - 2014-12-15

### Added

- Check user has permission to create resources in duplciation action and when
  displaying the "Duplicate Model" action item.

## 0.0.1 - 2014-06-02

- Initial release

[unreleased]: https://github.com/zorab47/active_admin-duplicatable/compare/v0.3.0...HEAD
[0.1.0]: https://github.com/zorab47/active_admin-duplicatable/compare/v0.0.1...v0.1.0
[0.2.0]: https://github.com/zorab47/active_admin-duplicatable/compare/v0.1.0...v0.2.0
[0.3.0]: https://github.com/zorab47/active_admin-duplicatable/compare/v0.2.0...v0.3.0
