/// The icon set, exported straight out of the Figma file.
///
/// Every glyph is the artboard's own vector, not a Material look-alike: the
/// file draws Lucide-style strokes at 1.5–1.75 and Material's icons are a
/// visibly different weight and corner treatment.
///
/// Each string keeps its native viewBox and stroke width, so rendering one at
/// the size the artboard uses reproduces the artboard exactly; rendering it
/// larger scales the stroke the same way Figma does. Colours are stripped to
/// `currentColor` and supplied by [SmasherIcon].
abstract final class SmasherIcons {
  /// Back header.
  static const String arrowLeft =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19 12H5M12 5L5 12L12 19" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Hero CTA and tile links.
  static const String arrowRight =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4.16663 9.99935H15.8333M9.99996 15.8327L15.8333 9.99935L9.99996 4.16602" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Trailing glyph in a ChevronTile.
  static const String chevronRight =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 12L10 8L6 4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Success ticks.
  static const String check =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13.3333 4.33398L5.99996 11.6673L2.66663 8.33398" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Confirmed states.
  static const String checkCircle =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.5 9L10.8 15L7.5 12M12 2.5C17.25 2.5 21.5 6.75 21.5 12C21.5 17.25 17.25 21.5 12 21.5C6.75 21.5 2.5 17.25 2.5 12C2.5 6.75 6.75 2.5 12 2.5Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Dismiss.
  static const String close =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 4L4 12M4 4L12 12" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Privacy notes, info strips, footnotes.
  static const String lock =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8 11V7C8 4.79 9.79 3 12 3C14.21 3 16 4.79 16 7V11M7 11H17C18.1 11 19 11.9 19 13V19C19 20.1 18.1 21 17 21H7C5.9 21 5 20.1 5 19V13C5 11.9 5.9 11 7 11Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Invitation preview.
  static const String shield =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3.3335 4.16699L10.0002 1.66699L16.6668 4.16699V9.58366C16.6668 13.7503 12.9168 16.667 10.0002 18.3337C7.0835 16.667 3.3335 13.7503 3.3335 9.58366V4.16699Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Verified / safety.
  static const String shieldCheck =
      r'''<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.7333 15.7332L14.6667 18.6665L20.2667 13.0665M16 2.6665L5.33334 6.6665V15.3332C5.33334 21.9998 11.3333 26.6665 16 29.3332C20.6667 26.6665 26.6667 21.9998 26.6667 15.3332V6.6665L16 2.6665Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Invite code.
  static const String key =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.875 11.125L16.875 3.125M14.2083 5.79167L16.375 7.95833M12.0417 7.95833L14.2083 10.125M6.45833 10.2083C8.3 10.2083 9.79167 11.7 9.79167 13.5417C9.79167 15.3833 8.3 16.875 6.45833 16.875C4.61667 16.875 3.125 15.3833 3.125 13.5417C3.125 11.7 4.61667 10.2083 6.45833 10.2083Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// QR invitation and scanning.
  static const String qrCode =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11.6667 11.6667V14.1667M14.1667 11.6667H17.5M17.5 14.1667V17.5M11.6667 17.5H14.1667M3.33333 2.5H7.5C7.95833 2.5 8.33333 2.875 8.33333 3.33333V7.5C8.33333 7.95833 7.95833 8.33333 7.5 8.33333H3.33333C2.875 8.33333 2.5 7.95833 2.5 7.5V3.33333C2.5 2.875 2.875 2.5 3.33333 2.5ZM12.5 2.5H16.6667C17.125 2.5 17.5 2.875 17.5 3.33333V7.5C17.5 7.95833 17.125 8.33333 16.6667 8.33333H12.5C12.0417 8.33333 11.6667 7.95833 11.6667 7.5V3.33333C11.6667 2.875 12.0417 2.5 12.5 2.5ZM3.33333 11.6667H7.5C7.95833 11.6667 8.33333 12.0417 8.33333 12.5V16.6667C8.33333 17.125 7.95833 17.5 7.5 17.5H3.33333C2.875 17.5 2.5 17.125 2.5 16.6667V12.5C2.5 12.0417 2.875 11.6667 3.33333 11.6667Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Share an invitation.
  static const String share =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.16667 8.75033L12.8333 5.41699M7.16667 11.2503L12.8333 14.5837M15 1.66699C16.3833 1.66699 17.5 2.78366 17.5 4.16699C17.5 5.55033 16.3833 6.66699 15 6.66699C13.6167 6.66699 12.5 5.55033 12.5 4.16699C12.5 2.78366 13.6167 1.66699 15 1.66699ZM5 7.50033C6.38333 7.50033 7.5 8.61699 7.5 10.0003C7.5 11.3837 6.38333 12.5003 5 12.5003C3.61667 12.5003 2.5 11.3837 2.5 10.0003C2.5 8.61699 3.61667 7.50033 5 7.50033ZM15 13.3337C16.3833 13.3337 17.5 14.4503 17.5 15.8337C17.5 17.217 16.3833 18.3337 15 18.3337C13.6167 18.3337 12.5 17.217 12.5 15.8337C12.5 14.4503 13.6167 13.3337 15 13.3337Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// QR scanner.
  static const String camera =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.83333 5.83301H2.5V16.6663H17.5V5.83301H14.1667L12.5 3.33301H7.5L5.83333 5.83301Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Face ID.
  static const String scanFace =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.5 6.66667V4.16667C2.5 3.25 3.25 2.5 4.16667 2.5H6.66667M13.3333 2.5H15.8333C16.75 2.5 17.5 3.25 17.5 4.16667V6.66667M17.5 13.3333V15.8333C17.5 16.75 16.75 17.5 15.8333 17.5H13.3333M6.66667 17.5H4.16667C3.25 17.5 2.5 16.75 2.5 15.8333V13.3333M7.5 12.3333C8.16667 13.25 9 13.6667 10 13.6667C11 13.6667 11.8333 13.25 12.5 12.3333M7.91667 8.25C8.19167 8.25 8.41667 8.475 8.41667 8.75C8.41667 9.025 8.19167 9.25 7.91667 9.25C7.64167 9.25 7.41667 9.025 7.41667 8.75C7.41667 8.475 7.64167 8.25 7.91667 8.25ZM12.0833 8.25C12.3583 8.25 12.5833 8.475 12.5833 8.75C12.5833 9.025 12.3583 9.25 12.0833 9.25C11.8083 9.25 11.5833 9.025 11.5833 8.75C11.5833 8.475 11.8083 8.25 12.0833 8.25Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Join a circle.
  static const String userPlus =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M1.66675 17.0837C1.66675 13.8587 4.27508 11.2503 7.50008 11.2503C8.79175 11.2503 9.98341 11.667 10.9501 12.3837M15.0001 8.75033V15.417M11.6667 12.0837H18.3334M7.50008 2.91699C9.34175 2.91699 10.8334 4.40866 10.8334 6.25033C10.8334 8.09199 9.34175 9.58366 7.50008 9.58366C5.65841 9.58366 4.16675 8.09199 4.16675 6.25033C4.16675 4.40866 5.65841 2.91699 7.50008 2.91699Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Create a circle / invite people.
  static const String usersPlus =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><g clip-path="url(#clip0_188_9992)"><path d="M10.8333 16.667V15.0003C10.8333 14.1163 10.4821 13.2684 9.85694 12.6433C9.23182 12.0182 8.38397 11.667 7.49992 11.667H4.16659C3.28253 11.667 2.43468 12.0182 1.80956 12.6433C1.18444 13.2684 0.833252 14.1163 0.833252 15.0003V16.667" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M5.83333 8.33366C7.67428 8.33366 9.16667 6.84127 9.16667 5.00033C9.16667 3.15938 7.67428 1.66699 5.83333 1.66699C3.99238 1.66699 2.5 3.15938 2.5 5.00033C2.5 6.84127 3.99238 8.33366 5.83333 8.33366Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.5 5.16699C13.1669 5.38619 13.7476 5.81034 14.1592 6.37896C14.5709 6.94759 14.7925 7.63166 14.7925 8.33366C14.7925 9.03565 14.5709 9.71973 14.1592 10.2884C13.7476 10.857 13.1669 11.2811 12.5 11.5003" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M15.8333 12.5V17.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M18.3333 15H13.3333" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></g><defs><clipPath id="clip0_188_9992"><rect width="20" height="20" fill="currentColor"/></clipPath></defs></svg>''';

  /// Members and circle settings.
  static const String users =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2 20.25C2 16.94 4.69 14.25 8 14.25H10C13.31 14.25 16 16.94 16 20.25M16 4.85C17.88 4.85 19.4 6.37 19.4 8.25C19.4 10.13 17.88 11.65 16 11.65M17 14.45C19.76 14.45 22 16.69 22 19.45V20.25M9 3.75C10.93 3.75 12.5 5.32 12.5 7.25C12.5 9.18 10.93 10.75 9 10.75C7.07 10.75 5.5 9.18 5.5 7.25C5.5 5.32 7.07 3.75 9 3.75Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Pending request.
  static const String clock =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 6.5V12L16 14M12 2.5C17.25 2.5 21.5 6.75 21.5 12C21.5 17.25 17.25 21.5 12 21.5C6.75 21.5 2.5 17.25 2.5 12C2.5 6.75 6.75 2.5 12 2.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Email verification.
  static const String mail =
      r'''<svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 9.33333L16 18L28 9.33333M4 8H28V24H4V8Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Privacy / reveal.
  static const String eye =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9.99996 4.16602C6.99996 4.16602 4.16663 6.24935 1.66663 9.99935C4.16663 13.7493 6.99996 15.8327 9.99996 15.8327C13 15.8327 15.8333 13.7493 18.3333 9.99935C15.8333 6.24935 13 4.16602 9.99996 4.16602Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Upload a photo.
  static const String upload =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10 13.3333V2.5M14.1667 6.66667L10 2.5L5.83337 6.66667M3.33337 15V16.6667C3.33337 17.125 3.70837 17.5 4.16671 17.5H15.8334C16.2917 17.5 16.6667 17.125 16.6667 16.6667V15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Refresh status.
  static const String refresh =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17.0833 9.99935C17.0833 13.916 13.9166 17.0827 9.99996 17.0827C7.24996 17.0827 4.85829 15.4993 3.69996 13.2077M2.91663 9.99935C2.91663 6.08268 6.08329 2.91602 9.99996 2.91602C12.75 2.91602 15.1416 4.49935 16.3 6.79102M16.25 2.91602V6.83268H12.3333M3.74996 17.0827V13.166H7.66663" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Open elsewhere.
  static const String externalLink =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17.5 8.33333V2.5H11.6667M17.5 2.5L8.33333 11.6667M15 10.8333V16.6667C15 17.125 14.625 17.5 14.1667 17.5H3.33333C2.875 17.5 2.5 17.125 2.5 16.6667V5.83333C2.5 5.375 2.875 5 3.33333 5H9.16667" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Account and app settings.
  static const String settings =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20M4 12H20M4 17H20M9 5C10.1 5 11 5.9 11 7C11 8.1 10.1 9 9 9C7.9 9 7 8.1 7 7C7 5.9 7.9 5 9 5ZM15 10C16.1 10 17 10.9 17 12C17 13.1 16.1 14 15 14C13.9 14 13 13.1 13 12C13 10.9 13.9 10 15 10ZM9 15C10.1 15 11 15.9 11 17C11 18.1 10.1 19 9 19C7.9 19 7 18.1 7 17C7 15.9 7.9 15 9 15Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Backspace on a code field.
  static const String delete =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M18 9.5L12.5 15M12.5 9.5L18 15M9 5H21V19H9L3 12L9 5Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Error state.
  static const String alertCircle =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 7V13M12 2.5C17.25 2.5 21.5 6.75 21.5 12C21.5 17.25 17.25 21.5 12 21.5C6.75 21.5 2.5 17.25 2.5 12C2.5 6.75 6.75 2.5 12 2.5ZM12 15.9C12.33 15.9 12.6 16.17 12.6 16.5C12.6 16.83 12.33 17.1 12 17.1C11.67 17.1 11.4 16.83 11.4 16.5C11.4 16.17 11.67 15.9 12 15.9Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Warning state.
  static const String alertTriangle =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 9.5V14.5M12 3.5L22 20.5H2L12 3.5ZM12 16.9C12.33 16.9 12.6 17.17 12.6 17.5C12.6 17.83 12.33 18.1 12 18.1C11.67 18.1 11.4 17.83 11.4 17.5C11.4 17.17 11.67 16.9 12 16.9Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Notifications button in module headers.
  static const String bell =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15 6.66699C15 5.34091 14.4732 4.06914 13.5355 3.13146C12.5979 2.19378 11.3261 1.66699 10 1.66699C8.67392 1.66699 7.40215 2.19378 6.46447 3.13146C5.52678 4.06914 5 5.34091 5 6.66699C5 12.5003 2.5 14.167 2.5 14.167H17.5C17.5 14.167 15 12.5003 15 6.66699Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/><path d="M11.4417 17.5C11.2952 17.7526 11.0849 17.9622 10.8319 18.1079C10.5789 18.2537 10.292 18.3304 10 18.3304C9.70803 18.3304 9.42117 18.2537 9.16816 18.1079C8.91515 17.9622 8.70486 17.7526 8.55835 17.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>''';

  /// Circle pill dropdown.
  static const String chevronDown =
      r'''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3.5 5.25L7 8.75L10.5 5.25" stroke="currentColor" stroke-width="1.51667" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Filled 4-point star on the hero eyebrow chip.
  static const String sparkle =
      r'''<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 1L7.1 4.15L10.5 5L7.1 5.85L6 9L4.9 5.85L1.5 5L4.9 4.15L6 1Z" fill="currentColor"/></svg>''';

  /// Matches tile.
  static const String sparkles =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.0001 2.5L11.5834 7L15.8334 8.33333L11.5834 9.66667L10.0001 14.1667L8.41675 9.66667L4.16675 8.33333L8.41675 7L10.0001 2.5Z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/><path d="M15.8333 5.49967C16.5697 5.49967 17.1667 4.90272 17.1667 4.16634C17.1667 3.42996 16.5697 2.83301 15.8333 2.83301C15.097 2.83301 14.5 3.42996 14.5 4.16634C14.5 4.90272 15.097 5.49967 15.8333 5.49967Z" fill="currentColor"/><path d="M4.16659 16.4997C4.76489 16.4997 5.24992 16.0146 5.24992 15.4163C5.24992 14.818 4.76489 14.333 4.16659 14.333C3.56828 14.333 3.08325 14.818 3.08325 15.4163C3.08325 16.0146 3.56828 16.4997 4.16659 16.4997Z" fill="currentColor"/></svg>''';

  /// Proposals tile.
  static const String calendarCheck =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.1666 4.16699H5.83325C4.45254 4.16699 3.33325 5.28628 3.33325 6.66699V15.0003C3.33325 16.381 4.45254 17.5003 5.83325 17.5003H14.1666C15.5473 17.5003 16.6666 16.381 16.6666 15.0003V6.66699C16.6666 5.28628 15.5473 4.16699 14.1666 4.16699Z" stroke="currentColor" stroke-width="1.5"/><path d="M6.66659 2.5V5.83333M13.3333 2.5V5.83333M3.33325 8.33333H16.6666" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M7.91675 12.917L9.58341 14.5837L12.5001 11.667" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Idea Deck card.
  static const String layers =
      r'''<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M11 2.75L2.75 7.33333L11 11.9167L19.25 7.33333L11 2.75Z" stroke="currentColor" stroke-width="1.65" stroke-linejoin="round"/><path opacity="0.75" d="M2.75 11.458L11 16.0413L19.25 11.458" stroke="currentColor" stroke-width="1.65" stroke-linecap="round" stroke-linejoin="round"/><path opacity="0.45" d="M2.75 15.583L11 20.1663L19.25 15.583" stroke="currentColor" stroke-width="1.65" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Edit profile pill.
  static const String edit =
      r'''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 11.667H12.25" stroke="currentColor" stroke-width="1.16667" stroke-linecap="round"/><path d="M9.625 2.04212C9.85706 1.81006 10.1718 1.67969 10.5 1.67969C10.6625 1.67969 10.8234 1.71169 10.9735 1.77388C11.1237 1.83607 11.2601 1.92722 11.375 2.04212C11.4899 2.15703 11.5811 2.29344 11.6432 2.44358C11.7054 2.59371 11.7374 2.75462 11.7374 2.91712C11.7374 3.07963 11.7054 3.24054 11.6432 3.39067C11.5811 3.5408 11.4899 3.67722 11.375 3.79212L4.08333 11.0838L1.75 11.6671L2.33333 9.33379L9.625 2.04212Z" stroke="currentColor" stroke-width="1.16667" stroke-linejoin="round"/></svg>''';

  /// Circle badge on the profile hero.
  static const String heart =
      r'''<svg width="11" height="11" viewBox="0 0 11 11" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.49994 9.62528C5.49994 9.62528 2.06244 7.47112 1.14578 5.50028C0.903776 4.93106 0.879499 4.29273 1.07757 3.70678C1.27563 3.12082 1.68222 2.62813 2.21995 2.32247C2.75768 2.01682 3.38901 1.91953 3.99381 2.04912C4.59861 2.17871 5.13466 2.52614 5.49994 3.02528C5.86523 2.52614 6.40127 2.17871 7.00607 2.04912C7.61087 1.91953 8.24221 2.01682 8.77994 2.32247C9.31767 2.62813 9.72425 3.12082 9.92232 3.70678C10.1204 4.29273 10.0961 4.93106 9.85411 5.50028C8.93744 7.47112 5.49994 9.62528 5.49994 9.62528Z" fill="currentColor"/></svg>''';

  /// 28px tick on Circle Ready / You're In.
  static const String statusCheck =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M23.3332 7L10.4998 19.8333L4.6665 14" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// 28px glyph on Waiting for Approval.
  static const String hourglass =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5.83325 25.667H22.1666" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M5.83325 2.33301H22.1666" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M19.8334 25.6667V20.7667C19.8246 20.1512 19.573 19.5641 19.1334 19.1333L14.0001 14L8.86675 19.1333C8.42711 19.5641 8.17551 20.1512 8.16675 20.7667V25.6667" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M8.16675 2.33301V7.23301C8.17551 7.84847 8.42711 8.43554 8.86675 8.86634L14.0001 13.9997L19.1334 8.86634C19.573 8.43554 19.8246 7.84847 19.8334 7.23301V2.33301" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// 28px glyph on Invitation Not Found.
  static const String search =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12.8334 21.0003C17.3437 21.0003 21.0001 17.344 21.0001 12.8337C21.0001 8.32333 17.3437 4.66699 12.8334 4.66699C8.32309 4.66699 4.66675 8.32333 4.66675 12.8337C4.66675 17.344 8.32309 21.0003 12.8334 21.0003Z" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M23.3333 23.3333L19.25 19.25" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// 28px glyph on Invitation Expired.
  static const String statusClock =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14 24.5C19.799 24.5 24.5 19.799 24.5 14C24.5 8.20101 19.799 3.5 14 3.5C8.20101 3.5 3.5 8.20101 3.5 14C3.5 19.799 8.20101 24.5 14 24.5Z" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M14 8.16699V14.0003L17.5 16.3337" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// 28px glyph on Invitation Revoked.
  static const String xCircle =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14 24.5C19.799 24.5 24.5 19.799 24.5 14C24.5 8.20101 19.799 3.5 14 3.5C8.20101 3.5 3.5 8.20101 3.5 14C3.5 19.799 8.20101 24.5 14 24.5Z" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M17.5 10.5L10.5 17.5" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M10.5 10.5L17.5 17.5" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// 28px glyph on Circle Unavailable.
  static const String statusAlert =
      r'''<svg width="28" height="28" viewBox="0 0 28 28" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14 10.5V15.1667" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M14 19.833H14.0117" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/><path d="M12.0166 4.55046L2.09989 21.0005C1.89661 21.3524 1.78879 21.7514 1.78713 22.1579C1.78546 22.5643 1.89 22.9642 2.09039 23.3178C2.29078 23.6714 2.58007 23.9666 2.92961 24.174C3.27915 24.3814 3.67681 24.494 4.08322 24.5005H23.9166C24.323 24.494 24.7206 24.3814 25.0702 24.174C25.4197 23.9666 25.709 23.6714 25.9094 23.3178C26.1098 22.9642 26.2143 22.5643 26.2126 22.1579C26.211 21.7514 26.1032 21.3524 25.8999 21.0005L15.9832 4.55046C15.774 4.21281 15.482 3.93416 15.1349 3.74094C14.7878 3.54771 14.3971 3.44629 13.9999 3.44629C13.6026 3.44629 13.212 3.54771 12.8649 3.74094C12.5178 3.93416 12.2258 4.21281 12.0166 4.55046Z" stroke="currentColor" stroke-width="2.04167" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Bottom nav — Together.
  static const String together =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16 21V19C16 17.9391 15.5786 16.9217 14.8284 16.1716C14.0783 15.4214 13.0609 15 12 15H6C4.93913 15 3.92172 15.4214 3.17157 16.1716C2.42143 16.9217 2 17.9391 2 19V21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M9 11C11.2091 11 13 9.20914 13 7C13 4.79086 11.2091 3 9 3C6.79086 3 5 4.79086 5 7C5 9.20914 6.79086 11 9 11Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M22 20.9999V18.9999C21.9993 18.1136 21.7044 17.2527 21.1614 16.5522C20.6184 15.8517 19.8581 15.3515 19 15.1299" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M16 3.12988C16.8604 3.35018 17.623 3.85058 18.1676 4.55219C18.7122 5.2538 19.0078 6.11671 19.0078 7.00488C19.0078 7.89305 18.7122 8.75596 18.1676 9.45757C17.623 10.1592 16.8604 10.6596 16 10.8799" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Bottom nav — Moments.
  static const String moments =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19 4H5C3.89543 4 3 4.89543 3 6V20C3 21.1046 3.89543 22 5 22H19C20.1046 22 21 21.1046 21 20V6C21 4.89543 20.1046 4 19 4Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M16 2V6" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M8 2V6" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M3 10H21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Bottom nav — Stories.
  static const String stories =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 7V21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M3 18C2.73478 18 2.48043 17.8946 2.29289 17.7071C2.10536 17.5196 2 17.2652 2 17V4C2 3.73478 2.10536 3.48043 2.29289 3.29289C2.48043 3.10536 2.73478 3 3 3H8C9.06087 3 10.0783 3.42143 10.8284 4.17157C11.5786 4.92172 12 5.93913 12 7C12 5.93913 12.4214 4.92172 13.1716 4.17157C13.9217 3.42143 14.9391 3 16 3H21C21.2652 3 21.5196 3.10536 21.7071 3.29289C21.8946 3.48043 22 3.73478 22 4V17C22 17.2652 21.8946 17.5196 21.7071 17.7071C21.5196 17.8946 21.2652 18 21 18H15C14.2044 18 13.4413 18.3161 12.8787 18.8787C12.3161 19.4413 12 20.2044 12 21C12 20.2044 11.6839 19.4413 11.1213 18.8787C10.5587 18.3161 9.79565 18 9 18H3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Bottom nav — Messages.
  static const String messages =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.9 20C9.80858 20.9791 12.0041 21.2443 14.0909 20.7478C16.1777 20.2514 18.0186 19.0259 19.2818 17.2922C20.545 15.5586 21.1474 13.4308 20.9806 11.2922C20.8137 9.15366 19.8886 7.14502 18.3718 5.62824C16.855 4.11146 14.8464 3.1863 12.7078 3.01946C10.5693 2.85263 8.44147 3.45509 6.70782 4.71829C4.97417 5.98149 3.74869 7.82236 3.25222 9.90916C2.75575 11.996 3.02094 14.1915 4 16.1L2 22L7.9 20Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Bottom nav — Profile.
  static const String profile =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19 21V19C19 17.9391 18.5786 16.9217 17.8284 16.1716C17.0783 15.4214 16.0609 15 15 15H9C7.93913 15 6.92172 15.4214 6.17157 16.1716C5.42143 16.9217 5 17.9391 5 19V21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M12 11C14.2091 11 16 9.20914 16 7C16 4.79086 14.2091 3 12 3C9.79086 3 8 4.79086 8 7C8 9.20914 9.79086 11 12 11Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Every icon by name, for the gallery.
  /// Proposal sent — paper plane, 30px on the gradient status tile.
  static const String send =
      r'''<svg width="30" height="30" viewBox="0 0 30 30" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M26.875 3.125L3.125 13.125L13.75 16.25L16.875 26.875L26.875 3.125Z" stroke="currentColor" stroke-width="2.25" stroke-linecap="round" stroke-linejoin="round"/><path d="M26.875 3.125L13.75 16.25" stroke="currentColor" stroke-width="2.25" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// "No proposals yet" tile — the 20px plane.
  static const String sendSmall =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17.9163 2.08301L2.08301 8.74967L9.16634 10.833L11.2497 17.9163L17.9163 2.08301Z" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Date rows and the "Nothing planned yet" tile.
  static const String calendar =
      r'''<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.25 3.75H3.75C2.92157 3.75 2.25 4.42157 2.25 5.25V14.25C2.25 15.0784 2.92157 15.75 3.75 15.75H14.25C15.0784 15.75 15.75 15.0784 15.75 14.25V5.25C15.75 4.42157 15.0784 3.75 14.25 3.75Z" stroke="currentColor" stroke-width="1.5"/><path d="M2.25 7.5H15.75" stroke="currentColor" stroke-width="1.5"/><path d="M6 2.25V5.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/><path d="M12 2.25V5.25" stroke="currentColor" stroke-width="1.5" stroke-linecap="round"/></svg>''';

  /// Time rows and the New Time Sent tile.
  static const String time =
      r'''<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 15.75C12.7279 15.75 15.75 12.7279 15.75 9C15.75 5.27208 12.7279 2.25 9 2.25C5.27208 2.25 2.25 5.27208 2.25 9C2.25 12.7279 5.27208 15.75 9 15.75Z" stroke="currentColor" stroke-width="1.5"/><path d="M9 5.25V9L11.625 10.5" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// The note line on a received proposal.
  static const String note =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.66699 2.66699H13.3337V13.3337H2.66699V2.66699Z" stroke="currentColor" stroke-width="1.33333" stroke-linejoin="round"/><path d="M5.33301 6H10.6663" stroke="currentColor" stroke-width="1.33333" stroke-linecap="round"/><path d="M5.33301 8.66699H8.66634" stroke="currentColor" stroke-width="1.33333" stroke-linecap="round"/></svg>''';

  /// Round tick — "answer saved" (16px) and It's planned (34px).
  static const String successCheck =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.00033 14.3337C11.4981 14.3337 14.3337 11.4981 14.3337 8.00033C14.3337 4.50252 11.4981 1.66699 8.00033 1.66699C4.50252 1.66699 1.66699 4.50252 1.66699 8.00033C1.66699 11.4981 4.50252 14.3337 8.00033 14.3337Z" stroke="currentColor" stroke-width="1.2"/><path d="M5.33301 8.33333L6.99967 10L10.6663 6" stroke="currentColor" stroke-width="1.33333" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Filled four-point star on the matched-answer card.
  static const String sparkleSolid =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 2L14 9L21 11L14 13L12 20L10 13L3 11L10 9L12 2Z" fill="currentColor"/></svg>''';

  /// Idea Deck empty state — the card stack.
  static const String deck =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M17 6H7C5.34315 6 4 7.34315 4 9V15C4 16.6569 5.34315 18 7 18H17C18.6569 18 20 16.6569 20 15V9C20 7.34315 18.6569 6 17 6Z" stroke="currentColor" stroke-width="2"/><path d="M7 6V4.5C7 3.67 7.67 3 8.5 3H15.5C16.33 3 17 3.67 17 4.5V6" stroke="currentColor" stroke-width="2"/></svg>''';

  /// Load-failure tile (Idea Deck, Together).
  static const String errorCircle =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 21.5C17.2467 21.5 21.5 17.2467 21.5 12C21.5 6.75329 17.2467 2.5 12 2.5C6.75329 2.5 2.5 6.75329 2.5 12C2.5 17.2467 6.75329 21.5 12 21.5Z" stroke="currentColor" stroke-width="2"/><path d="M12 7.5V13" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M12.0004 17.2996C12.6079 17.2996 13.1004 16.8071 13.1004 16.1996C13.1004 15.5921 12.6079 15.0996 12.0004 15.0996C11.3929 15.0996 10.9004 15.5921 10.9004 16.1996C10.9004 16.8071 11.3929 17.2996 12.0004 17.2996Z" fill="currentColor"/></svg>''';

  /// Decline — bold X on the red tile.
  static const String cross =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 6L18 18" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"/><path d="M18 6L6 18" stroke="currentColor" stroke-width="2.2" stroke-linecap="round"/></svg>''';

  /// "No matches yet" tile.
  static const String heartOutline =
      r'''<svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10.0003 17.0833C10.0003 17.0833 2.91699 12.9167 2.91699 7.91667C2.91699 5.41667 4.83366 3.75 7.08366 3.75C8.33366 3.75 9.41699 4.33333 10.0003 5.25C10.5837 4.33333 11.667 3.75 12.917 3.75C15.167 3.75 17.0837 5.41667 17.0837 7.91667C17.0837 12.9167 10.0003 17.0833 10.0003 17.0833Z" stroke="currentColor" stroke-width="1.66667" stroke-linejoin="round"/></svg>''';

  /// 12px chevron after an inline CTA.
  static const String chevronSmall =
      r'''<svg width="12" height="12" viewBox="0 0 12 12" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4.5 3L7.5 6L4.5 9" stroke="currentColor" stroke-width="1.1" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Offline banner.
  static const String wifiOff =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2 5.66699C5 3.00033 11 3.00033 14 5.66699" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/><path d="M4.33301 8.3334C6.46634 6.5334 9.53301 6.5334 11.6663 8.3334" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/><path d="M6.66699 10.8662C7.46699 10.1995 8.53366 10.1995 9.33366 10.8662" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/><path d="M2 2L14 14" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/></svg>''';

  /// Month navigation — previous.
  static const String chevronLeftSmall =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M10 4L6 8L10 12" stroke="currentColor" stroke-width="1.46667" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Month navigation — next; ticket card affordance.
  static const String chevronRightSmall =
      r'''<svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 4L10 8L6 12" stroke="currentColor" stroke-width="1.46667" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// Share with / participants.
  static const String people =
      r'''<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.75 8.25C7.99264 8.25 9 7.24264 9 6C9 4.75736 7.99264 3.75 6.75 3.75C5.50736 3.75 4.5 4.75736 4.5 6C4.5 7.24264 5.50736 8.25 6.75 8.25Z" stroke="currentColor" stroke-width="1.35"/><path d="M2.625 14.25C2.625 11.625 4.5 10.125 6.75 10.125C9 10.125 10.875 11.625 10.875 14.25" stroke="currentColor" stroke-width="1.35" stroke-linecap="round"/><path d="M12.7499 8.47539C13.7026 8.47539 14.4749 7.70308 14.4749 6.75039C14.4749 5.7977 13.7026 5.02539 12.7499 5.02539C11.7972 5.02539 11.0249 5.7977 11.0249 6.75039C11.0249 7.70308 11.7972 8.47539 12.7499 8.47539Z" stroke="currentColor" stroke-width="1.2"/><path d="M10.875 14.2504C10.875 12.1504 11.775 10.8754 13.35 10.6504" stroke="currentColor" stroke-width="1.2" stroke-linecap="round"/></svg>''';

  /// Location.
  static const String pin =
      r'''<svg width="18" height="18" viewBox="0 0 18 18" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 15.75C9 15.75 14.25 10.875 14.25 7.125C14.25 4.2 11.925 1.875 9 1.875C6.075 1.875 3.75 4.2 3.75 7.125C3.75 10.875 9 15.75 9 15.75Z" stroke="currentColor" stroke-width="1.5" stroke-linejoin="round"/><path d="M9 9C10.0355 9 10.875 8.16053 10.875 7.125C10.875 6.08947 10.0355 5.25 9 5.25C7.96447 5.25 7.125 6.08947 7.125 7.125C7.125 8.16053 7.96447 9 9 9Z" stroke="currentColor" stroke-width="1.5"/></svg>''';

  /// Calendar without rings — detail rows, no-moments-on-date.
  static const String calendarPlain =
      r'''<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.5 4.58398H5.5C3.98122 4.58398 2.75 5.8152 2.75 7.33398V16.5007C2.75 18.0194 3.98122 19.2507 5.5 19.2507H16.5C18.0188 19.2507 19.25 18.0194 19.25 16.5007V7.33398C19.25 5.8152 18.0188 4.58398 16.5 4.58398Z" stroke="currentColor" stroke-width="1.83333"/><path d="M2.75 9.16602H19.25" stroke="currentColor" stroke-width="1.83333"/></svg>''';

  /// Inline conflict warning.
  static const String alertSmall =
      r'''<svg width="14" height="14" viewBox="0 0 14 14" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7.00016 12.5423C10.0607 12.5423 12.5418 10.0612 12.5418 7.00065C12.5418 3.94007 10.0607 1.45898 7.00016 1.45898C3.93958 1.45898 1.4585 3.94007 1.4585 7.00065C1.4585 10.0612 3.93958 12.5423 7.00016 12.5423Z" stroke="currentColor" stroke-width="1.16667"/><path d="M7 4.375V7.58333" stroke="currentColor" stroke-width="1.16667" stroke-linecap="round"/><path d="M7.00007 10.0919C7.35445 10.0919 7.64173 9.80464 7.64173 9.45026C7.64173 9.09588 7.35445 8.80859 7.00007 8.80859C6.64568 8.80859 6.3584 9.09588 6.3584 9.45026C6.3584 9.80464 6.64568 10.0919 7.00007 10.0919Z" fill="currentColor"/></svg>''';

  /// Create — generated to match the 1.75 stroke set.
  static const String plus =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 5V19M5 12H19" stroke="currentColor" stroke-width="1.75" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String eyeLine =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M0.708496 8.49935C0.708496 8.49935 3.54183 3.54102 8.50016 3.54102C13.4585 3.54102 16.2918 8.49935 16.2918 8.49935C16.2918 8.49935 13.4585 13.4577 8.50016 13.4577C3.54183 13.4577 0.708496 8.49935 0.708496 8.49935Z" stroke="currentColor" stroke-width="1.275"/><path d="M8.5 10.625C9.6736 10.625 10.625 9.6736 10.625 8.5C10.625 7.32639 9.6736 6.375 8.5 6.375C7.32639 6.375 6.375 7.32639 6.375 8.5C6.375 9.6736 7.32639 10.625 8.5 10.625Z" stroke="currentColor" stroke-width="1.275"/></svg>''';

  /// P05.
  static const String peopleLine =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6.37516 8.14583C7.74437 8.14583 8.85433 7.03587 8.85433 5.66667C8.85433 4.29746 7.74437 3.1875 6.37516 3.1875C5.00596 3.1875 3.896 4.29746 3.896 5.66667C3.896 7.03587 5.00596 8.14583 6.37516 8.14583Z" stroke="currentColor" stroke-width="1.275"/><path d="M1.771 14.1667C1.771 11.6167 3.82516 9.5625 6.37516 9.5625C8.92516 9.5625 10.9793 11.6167 10.9793 14.1667" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/><path d="M11.3335 6.02148C12.3252 6.23398 13.1043 7.15482 13.1043 8.21732C13.1043 9.13815 12.6085 9.91732 11.8293 10.2715" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/><path d="M13.104 9.91602C14.5207 10.341 15.5832 11.6868 15.5832 13.2452" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String tick =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.1668 4.25L6.37516 12.0417L2.8335 8.5" stroke="currentColor" stroke-width="1.275" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P05.
  static const String image =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13.4583 2.83398H3.54167C2.75926 2.83398 2.125 3.46825 2.125 4.25065V12.7507C2.125 13.5331 2.75926 14.1673 3.54167 14.1673H13.4583C14.2407 14.1673 14.875 13.5331 14.875 12.7507V4.25065C14.875 3.46825 14.2407 2.83398 13.4583 2.83398Z" stroke="currentColor" stroke-width="1.275"/><path d="M6.375 8.14648C6.9618 8.14648 7.4375 7.67079 7.4375 7.08398C7.4375 6.49718 6.9618 6.02148 6.375 6.02148C5.7882 6.02148 5.3125 6.49718 5.3125 7.08398C5.3125 7.67079 5.7882 8.14648 6.375 8.14648Z" fill="currentColor"/><path d="M2.8335 12.0417L6.37516 8.5L9.2085 11.3333L11.3335 9.20833L14.1668 12.0417" stroke="currentColor" stroke-width="1.275" stroke-linejoin="round"/></svg>''';

  /// P05.
  static const String dot =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.50016 12.0423C10.4562 12.0423 12.0418 10.4567 12.0418 8.50065C12.0418 6.54464 10.4562 4.95898 8.50016 4.95898C6.54415 4.95898 4.9585 6.54464 4.9585 8.50065C4.9585 10.4567 6.54415 12.0423 8.50016 12.0423Z" fill="currentColor"/></svg>''';

  /// P05.
  static const String lockSmall =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.85433 7.08398H3.896C3.30919 7.08398 2.8335 7.55968 2.8335 8.14648V10.9798C2.8335 11.5666 3.30919 12.0423 3.896 12.0423H8.85433C9.44113 12.0423 9.91683 11.5666 9.91683 10.9798V8.14648C9.91683 7.55968 9.44113 7.08398 8.85433 7.08398Z" stroke="currentColor" stroke-width="1.275"/><path d="M4.9585 7.08333V4.95833C4.9585 4.48868 5.14507 4.03826 5.47716 3.70617C5.80926 3.37407 6.25968 3.1875 6.72933 3.1875C7.19898 3.1875 7.6494 3.37407 7.9815 3.70617C8.31359 4.03826 8.50016 4.48868 8.50016 4.95833V7.08333" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String faceSmall =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12.0417 2.125H13.4583C13.8341 2.125 14.1944 2.27426 14.4601 2.53993C14.7257 2.80561 14.875 3.16594 14.875 3.54167V4.95833M12.0417 14.875H13.4583C13.8341 14.875 14.1944 14.7257 14.4601 14.4601C14.7257 14.1944 14.875 13.8341 14.875 13.4583V12.0417M4.95833 14.875H3.54167C3.16594 14.875 2.80561 14.7257 2.53993 14.4601C2.27426 14.1944 2.125 13.8341 2.125 13.4583V12.0417M4.95833 2.125H3.54167C3.16594 2.125 2.80561 2.27426 2.53993 2.53993C2.27426 2.80561 2.125 3.16594 2.125 3.54167V4.95833" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/><path d="M6.37484 10.6257C6.76604 10.6257 7.08317 10.3085 7.08317 9.91732C7.08317 9.52612 6.76604 9.20898 6.37484 9.20898C5.98364 9.20898 5.6665 9.52612 5.6665 9.91732C5.6665 10.3085 5.98364 10.6257 6.37484 10.6257Z" fill="currentColor"/><path d="M10.6248 10.6257C11.016 10.6257 11.3332 10.3085 11.3332 9.91732C11.3332 9.52612 11.016 9.20898 10.6248 9.20898C10.2336 9.20898 9.9165 9.52612 9.9165 9.91732C9.9165 10.3085 10.2336 10.6257 10.6248 10.6257Z" fill="currentColor"/><path d="M6.729 12.3965C7.43734 12.8923 8.14567 12.8923 8.854 12.3965" stroke="currentColor" stroke-width="1.13333" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String monitor =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M13.4583 2.83398H3.54167C2.75926 2.83398 2.125 3.46825 2.125 4.25065V9.91732C2.125 10.6997 2.75926 11.334 3.54167 11.334H13.4583C14.2407 11.334 14.875 10.6997 14.875 9.91732V4.25065C14.875 3.46825 14.2407 2.83398 13.4583 2.83398Z" stroke="currentColor" stroke-width="1.275"/><path d="M5.6665 14.1673H11.3332M8.49984 11.334V14.1673" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String logout =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V5C3 4.46957 3.21071 3.96086 3.58579 3.58579C3.96086 3.21071 4.46957 3 5 3H9" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M16 17L21 12L16 7" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/><path d="M21 12H9" stroke="currentColor" stroke-width="2" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String messageSquare =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M14.875 10.625C14.875 11.0007 14.7257 11.3611 14.4601 11.6267C14.1944 11.8924 13.8341 12.0417 13.4583 12.0417H4.95833L2.125 14.875V3.54167C2.125 3.16594 2.27426 2.80561 2.53993 2.53993C2.80561 2.27426 3.16594 2.125 3.54167 2.125H13.4583C13.8341 2.125 14.1944 2.27426 14.4601 2.53993C14.7257 2.80561 14.875 3.16594 14.875 3.54167V10.625Z" stroke="currentColor" stroke-width="1.275" stroke-linejoin="round"/></svg>''';

  /// P05.
  static const String bellSmall =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.49984 2.125C6.54484 2.125 4.95817 3.71167 4.95817 5.66667V8.14583L3.5415 10.625H13.4582L12.0415 8.14583V5.66667C12.0415 3.71167 10.4548 2.125 8.49984 2.125Z" stroke="currentColor" stroke-width="1.275" stroke-linejoin="round"/><path d="M7.0835 12.75C7.0835 13.5292 7.721 14.1667 8.50016 14.1667C9.27933 14.1667 9.91683 13.5292 9.91683 12.75" stroke="currentColor" stroke-width="1.275" stroke-linecap="round"/></svg>''';

  /// P05.
  static const String trash =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 7H20" stroke="currentColor" stroke-width="2" stroke-linecap="round"/><path d="M9 7V5C9 4.46957 9.21071 3.96086 9.58579 3.58579C9.96086 3.21071 10.4696 3 11 3H13C13.5304 3 14.0391 3.21071 14.4142 3.58579C14.7893 3.96086 15 4.46957 15 5V7" stroke="currentColor" stroke-width="2"/><path d="M6 7L7 20C7 20.5304 7.21071 21.0391 7.58579 21.4142C7.96086 21.7893 8.46957 22 9 22H15C15.5304 22 16.0391 21.7893 16.4142 21.4142C16.7893 21.0391 17 20.5304 17 20L18 7" stroke="currentColor" stroke-width="2" stroke-linejoin="round"/></svg>''';

  /// P05.
  static const String cameraSmall =
      r'''<svg width="17" height="17" viewBox="0 0 17 17" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M2.83333 5.66667H4.95833L6.375 4.25H10.625L12.0417 5.66667H14.1667C14.3545 5.66667 14.5347 5.74129 14.6675 5.87413C14.8004 6.00697 14.875 6.18714 14.875 6.375V13.4583C14.875 13.6462 14.8004 13.8264 14.6675 13.9592C14.5347 14.092 14.3545 14.1667 14.1667 14.1667H2.83333C2.64547 14.1667 2.4653 14.092 2.33247 13.9592C2.19963 13.8264 2.125 13.6462 2.125 13.4583V6.375C2.125 6.18714 2.19963 6.00697 2.33247 5.87413C2.4653 5.74129 2.64547 5.66667 2.83333 5.66667Z" stroke="currentColor" stroke-width="1.275" stroke-linejoin="round"/><path d="M8.49967 12.3958C9.86888 12.3958 10.9788 11.2859 10.9788 9.91667C10.9788 8.54746 9.86888 7.4375 8.49967 7.4375C7.13047 7.4375 6.02051 8.54746 6.02051 9.91667C6.02051 11.2859 7.13047 12.3958 8.49967 12.3958Z" stroke="currentColor" stroke-width="1.275"/></svg>''';

  /// P05.
  static const String faceId =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 3H5C4.46957 3 3.96086 3.21071 3.58579 3.58579C3.21071 3.96086 3 4.46957 3 5V7" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/><path d="M17 3H19C19.5304 3 20.0391 3.21071 20.4142 3.58579C20.7893 3.96086 21 4.46957 21 5V7" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/><path d="M7 21H5C4.46957 21 3.96086 20.7893 3.58579 20.4142C3.21071 20.0391 3 19.5304 3 19V17" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/><path d="M17 21H19C19.5304 21 20.0391 20.7893 20.4142 20.4142C20.7893 20.0391 21 19.5304 21 19V17" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/><path d="M9 11C9.55228 11 10 10.5523 10 10C10 9.44772 9.55228 9 9 9C8.44772 9 8 9.44772 8 10C8 10.5523 8.44772 11 9 11Z" fill="currentColor"/><path d="M15 11C15.5523 11 16 10.5523 16 10C16 9.44772 15.5523 9 15 9C14.4477 9 14 9.44772 14 10C14 10.5523 14.4477 11 15 11Z" fill="currentColor"/><path d="M9 15C10 15.8 11 15.8 12 15" stroke="currentColor" stroke-width="1.6" stroke-linecap="round"/><path d="M12 8V12H13.5" stroke="currentColor" stroke-width="1.4" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P05.
  static const String pause =
      r'''<svg width="22" height="22" viewBox="0 0 22 22" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M8.25 3.66602H6.41667C5.91041 3.66602 5.5 4.07642 5.5 4.58268V17.416C5.5 17.9223 5.91041 18.3327 6.41667 18.3327H8.25C8.75626 18.3327 9.16667 17.9223 9.16667 17.416V4.58268C9.16667 4.07642 8.75626 3.66602 8.25 3.66602Z" fill="currentColor"/><path d="M15.583 3.66602H13.7497C13.2434 3.66602 12.833 4.07642 12.833 4.58268V17.416C12.833 17.9223 13.2434 18.3327 13.7497 18.3327H15.583C16.0893 18.3327 16.4997 17.9223 16.4997 17.416V4.58268C16.4997 4.07642 16.0893 3.66602 15.583 3.66602Z" fill="currentColor"/></svg>''';

  /// P06.
  static const String textType =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M5 6V5H19V6M12 5V19M9 19H15" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String video =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="3" y="6" width="13" height="12" rx="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M16 10.5L21 7.5V16.5L16 13.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String music =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 18V5L20 3V16" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><circle cx="6.5" cy="18" r="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><circle cx="17.5" cy="16" r="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String sticker =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M15.5 3H6C4.34 3 3 4.34 3 6V18C3 19.66 4.34 21 6 21H13L21 13V8.5L15.5 3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M13 21V16C13 14.34 14.34 13 16 13H21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M8.5 10H8.51M13.5 10H13.51" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String moreHorizontal =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="5" cy="12" r="1.6" fill="currentColor"/><circle cx="12" cy="12" r="1.6" fill="currentColor"/><circle cx="19" cy="12" r="1.6" fill="currentColor"/></svg>''';

  /// P06.
  static const String moreVertical =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="5" r="1.6" fill="currentColor"/><circle cx="12" cy="12" r="1.6" fill="currentColor"/><circle cx="12" cy="19" r="1.6" fill="currentColor"/></svg>''';

  /// P06.
  static const String layoutGrid =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="3.5" y="3.5" width="7" height="7" rx="1.8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><rect x="13.5" y="3.5" width="7" height="7" rx="1.8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><rect x="3.5" y="13.5" width="7" height="7" rx="1.8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><rect x="13.5" y="13.5" width="7" height="7" rx="1.8" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String pen =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16.5 3.5L20.5 7.5L8 20H4V16L16.5 3.5Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M14 6L18 10" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String mic =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="9" y="3" width="6" height="11" rx="3" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M5 11C5 14.87 8.13 18 12 18C15.87 18 19 14.87 19 11M12 18V21" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String play =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 4.8C7 4.02 7.85 3.54 8.52 3.95L19.1 10.45C19.73 10.84 19.73 11.76 19.1 12.15L8.52 18.65C7.85 19.06 7 18.58 7 17.8V4.8Z" fill="currentColor"/></svg>''';

  /// P06.
  static const String scissors =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="6" cy="6" r="3" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><circle cx="6" cy="18" r="3" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M20 4L8.12 15.88M14.47 14.48L20 20M8.12 8.12L12 12" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String poll =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 20V10M10 20V4M16 20V13M22 20H2" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String helpCircle =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M9.1 9C9.33 8.33 9.8 7.77 10.4 7.41C11.01 7.05 11.73 6.92 12.43 7.04C13.13 7.16 13.76 7.52 14.21 8.07C14.67 8.61 14.92 9.29 14.92 10C14.92 12 11.92 13 11.92 13M12 17H12.01" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String smile =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M8 14C8 14 9.5 16 12 16C14.5 16 16 14 16 14M9 9.5H9.01M15 9.5H15.01" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String sliders =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 21V14M4 10V3M12 21V12M12 8V3M20 21V16M20 12V3M1 14H7M9 8H15M17 16H23" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String alignCenter =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M4 6H20M7 12H17M5 18H19" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String palette =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><circle cx="8" cy="10" r="1.2" fill="currentColor"/><circle cx="12" cy="7.5" r="1.2" fill="currentColor"/><circle cx="16" cy="10" r="1.2" fill="currentColor"/><path d="M12 21C10.5 21 10 19.5 11 18.5C12 17.5 13.5 16 15.5 16H17C19.2 16 21 14.2 21 12" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String fontSize =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M3 19L8 5L13 19M4.8 14H11.2M15 19L18 11L21 19M15.9 16.5H20.1" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String fillDrop =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 3C12 3 6 9.5 6 14C6 17.31 8.69 20 12 20C15.31 20 18 17.31 18 14C18 9.5 12 3 12 3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String bold =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 5H13C15.21 5 17 6.79 17 9C17 11.21 15.21 12 13 12H7V5ZM7 12H14C16.21 12 18 13.79 18 16C18 18.21 16.21 19 14 19H7V12Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String italic =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M19 4H10M14 20H5M15 4L9 20" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String underline =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M6 4V10C6 13.31 8.69 16 12 16C15.31 16 18 13.31 18 10V4M4 20H20" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String fire =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 21C15.87 21 19 18.1 19 14.2C19 10 15.5 7.5 14.5 3C12 5 10.5 7 10.5 9.5C9.5 8.5 9 7.5 9 6.5C6.5 8.5 5 11.2 5 14.2C5 18.1 8.13 21 12 21Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String thumbsUp =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M7 10V20M15 5.88L14 10H19.83C20.46 10 21.05 10.3 21.43 10.8C21.8 11.3 21.92 11.95 21.74 12.56L19.41 20.56C19.16 21.4 18.39 22 17.5 22H4C3.45 22 3 21.55 3 21V11C3 10.45 3.45 10 4 10H6.76C7.14 10 7.49 9.79 7.66 9.45L11 2.5C11.94 2.5 12.8 3.03 13.24 3.88C13.67 4.72 14.03 5.23 15 5.88Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P06.
  static const String sparkleOutline =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 3L13.9 8.8L20 10.5L13.9 12.2L12 18L10.1 12.2L4 10.5L10.1 8.8L12 3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P07.
  static const String reply =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M9 14L4 9L9 4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M20 20V13C20 11.94 19.58 10.92 18.83 10.17C18.08 9.42 17.06 9 16 9H4" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P07.
  static const String copy =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="9" y="9" width="12" height="12" rx="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M5 15H4.5C3.67 15 3 14.33 3 13.5V4.5C3 3.67 3.67 3 4.5 3H13.5C14.33 3 15 3.67 15 4.5V5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P07.
  static const String stop =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="6" y="6" width="12" height="12" rx="2.5" fill="currentColor"/></svg>''';

  /// P07.
  static const String eraser =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M20 20H9L4.5 15.5C3.67 14.67 3.67 13.33 4.5 12.5L13.5 3.5C14.33 2.67 15.67 2.67 16.5 3.5L20.5 7.5C21.33 8.33 21.33 9.67 20.5 10.5L11 20" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M18 13L11 6" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P08.
  static const String phone =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><rect x="6" y="2.5" width="12" height="19" rx="2.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M11 18H13" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P08.
  static const String download =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 4V15M7 10.5L12 15.5L17 10.5M4.5 20H19.5" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P08.
  static const String star =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 3L14.78 8.63L21 9.54L16.5 13.93L17.56 20.12L12 17.2L6.44 20.12L7.5 13.93L3 9.54L9.22 8.63L12 3Z" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  /// P08.
  static const String starFilled =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M12 3L14.78 8.63L21 9.54L16.5 13.93L17.56 20.12L12 17.2L6.44 20.12L7.5 13.93L3 9.54L9.22 8.63L12 3Z" fill="currentColor"/></svg>''';

  /// P08.
  static const String ban =
      r'''<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><circle cx="12" cy="12" r="9" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/><path d="M5.7 5.7L18.3 18.3" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/></svg>''';

  static const Map<String, String> all = {
    'arrowLeft': arrowLeft,
    'arrowRight': arrowRight,
    'chevronRight': chevronRight,
    'check': check,
    'checkCircle': checkCircle,
    'close': close,
    'lock': lock,
    'shield': shield,
    'shieldCheck': shieldCheck,
    'key': key,
    'qrCode': qrCode,
    'share': share,
    'camera': camera,
    'scanFace': scanFace,
    'userPlus': userPlus,
    'usersPlus': usersPlus,
    'users': users,
    'clock': clock,
    'mail': mail,
    'eye': eye,
    'upload': upload,
    'refresh': refresh,
    'externalLink': externalLink,
    'settings': settings,
    'delete': delete,
    'alertCircle': alertCircle,
    'alertTriangle': alertTriangle,
    'bell': bell,
    'chevronDown': chevronDown,
    'sparkle': sparkle,
    'sparkles': sparkles,
    'calendarCheck': calendarCheck,
    'layers': layers,
    'edit': edit,
    'heart': heart,
    'statusCheck': statusCheck,
    'hourglass': hourglass,
    'search': search,
    'statusClock': statusClock,
    'xCircle': xCircle,
    'statusAlert': statusAlert,
    'together': together,
    'moments': moments,
    'stories': stories,
    'messages': messages,
    'profile': profile,
    'send': send,
    'sendSmall': sendSmall,
    'calendar': calendar,
    'time': time,
    'note': note,
    'successCheck': successCheck,
    'sparkleSolid': sparkleSolid,
    'deck': deck,
    'errorCircle': errorCircle,
    'cross': cross,
    'heartOutline': heartOutline,
    'chevronSmall': chevronSmall,
    'wifiOff': wifiOff,
    'chevronLeftSmall': chevronLeftSmall,
    'chevronRightSmall': chevronRightSmall,
    'people': people,
    'pin': pin,
    'calendarPlain': calendarPlain,
    'alertSmall': alertSmall,
    'plus': plus,
    'eyeLine': eyeLine,
    'peopleLine': peopleLine,
    'tick': tick,
    'image': image,
    'dot': dot,
    'lockSmall': lockSmall,
    'faceSmall': faceSmall,
    'monitor': monitor,
    'logout': logout,
    'messageSquare': messageSquare,
    'bellSmall': bellSmall,
    'trash': trash,
    'cameraSmall': cameraSmall,
    'faceId': faceId,
    'pause': pause,
    'textType': textType,
    'video': video,
    'music': music,
    'sticker': sticker,
    'moreHorizontal': moreHorizontal,
    'moreVertical': moreVertical,
    'layoutGrid': layoutGrid,
    'pen': pen,
    'mic': mic,
    'play': play,
    'scissors': scissors,
    'poll': poll,
    'helpCircle': helpCircle,
    'smile': smile,
    'sliders': sliders,
    'alignCenter': alignCenter,
    'palette': palette,
    'fontSize': fontSize,
    'fillDrop': fillDrop,
    'bold': bold,
    'italic': italic,
    'underline': underline,
    'fire': fire,
    'thumbsUp': thumbsUp,
    'sparkleOutline': sparkleOutline,
    'reply': reply,
    'copy': copy,
    'stop': stop,
    'eraser': eraser,
    'phone': phone,
    'download': download,
    'star': star,
    'starFilled': starFilled,
    'ban': ban,
  };
}
