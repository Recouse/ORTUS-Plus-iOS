// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Back
  internal static let back = L10n.tr("Localizable", "back")
  /// Cancel
  internal static let cancel = L10n.tr("Localizable", "cancel")
  /// Error
  internal static let error = L10n.tr("Localizable", "error")
  /// Info
  internal static let info = L10n.tr("Localizable", "info")
  /// OK
  internal static let ok = L10n.tr("Localizable", "ok")
  /// Success
  internal static let success = L10n.tr("Localizable", "success")
  /// Warning
  internal static let warning = L10n.tr("Localizable", "warning")

  internal enum Contacts {
    /// All Contacts
    internal static let all = L10n.tr("Localizable", "contacts.all")
    /// My Contacts
    internal static let my = L10n.tr("Localizable", "contacts.my")
    /// Contacts
    internal static let title = L10n.tr("Localizable", "contacts.title")
  }

  internal enum Courses {
    /// Courses
    internal static let title = L10n.tr("Localizable", "courses.title")
  }

  internal enum Grades {
    /// Grades
    internal static let title = L10n.tr("Localizable", "grades.title")
  }

  internal enum Home {
    /// Home
    internal static let title = L10n.tr("Localizable", "home.title")
  }

  internal enum News {
    /// News
    internal static let title = L10n.tr("Localizable", "news.title")
  }

  internal enum Notifications {
    /// Notifications
    internal static let title = L10n.tr("Localizable", "notifications.title")
  }

  internal enum Schedule {
    /// Schedule
    internal static let title = L10n.tr("Localizable", "schedule.title")
  }

  internal enum Settings {
    /// Settings
    internal static let title = L10n.tr("Localizable", "settings.title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle = Bundle(for: BundleToken.self)
}
// swiftlint:enable convenience_type
