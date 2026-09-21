# Smasher — design system notes

Generated from `Smasher-App.fig` (file key `qWrrN7lkZO5xzhPCWdRkaW`).
Everything below was read out of the Figma file, not assumed.

## What the file contains

| Page | Contents |
|---|---|
| 🏷️ Branding | 10 frames |
| Design | 247 screens at 390×844, in 26 sections |
| 🧩 Components | **missing — see below** |

**The Components page disappeared during this session.** It was present on the
first read (id `23:176`, 42 children) and gone a few minutes later. Only read
calls were made against the file. Check *File → Version history* in Figma.
Because of that, every widget here is derived from the screens themselves.

## Token architecture

A proper two-tier system, which is why this was quick:

- `Primitives` — 107 raw values
- `Theme — Light` / `Theme — Dark` — 33 semantic tokens each, aliasing primitives
- `Layout` — 47 values: spacing, radii, control heights, icon and avatar sizes,
  touch targets, motion durations
- 15 text styles (DM Sans SemiBold for display/heading, Inter for the rest)
- 5 effect styles, 4 gradient paint styles

Dark mode is fully defined in Figma. Both themes ship in `app_colors.dart`.

## Open issues found in the file

### 1. `State/Info` is wrong in light mode

| Token | Light | Dark |
|---|---|---|
| `State/Info` | `#7C3AED` | `#60A5FA` |
| `State/Info-Surface` | `#E9EFFD` (blue) | `#222C3E` (blue) |

In light mode Info resolves to the exact brand violet, so an info message is
indistinguishable from a brand element — while its own surface is blue-tinted
and dark mode uses blue. Almost certainly a mis-aliased variable.

Code currently mirrors Figma. Fix in `SmasherPalette.light.info` once decided.

### 2. Five light-mode roles collapse to one grey

`Background/Tertiary`, `Surface/Interactive`, `Surface/Selected`,
`Brand/Surface` and `Brand/Disabled` all resolve to `#F1F1F5`.
`Surface/Default`, `Surface/Elevated` and `Background/Secondary` all resolve to
`#FFFFFF`. Legal for a token system, but light mode has noticeably less
separation than dark, where those roles are genuinely distinct.

### 3. Two palettes live in `Primitives`

There is a complete warm/earthy set — terracotta, bronze, sand, sage, ivory,
stone — alongside the violet/neutral set. The themes alias only the violet set,
so roughly 50 primitives are dead weight from an earlier direction.

### 4. Screens drift from the tokens

The screens use values the token set does not define. Following the screens was
the instruction, so these are implemented as-is and isolated in
`SmasherScreenColors` and the extra entries in `SmasherRadius`.

| Screen value | Where | Nearest token |
|---|---|---|
| `#5C5C6B` | every description line | `Text/Secondary #52525E` |
| `#71717F` | footnotes, inactive nav | `Text/Tertiary #6B6B78` |
| `#8A8A96` | section labels | — |
| `#F0F0F5` | list dividers | `Border/Subtle #E4E4EB` |
| `#EDEDF3` / `#ECECF2` | bar hairlines | `Border/Subtle` |
| `#F3EEFE` | page icon tile | — |
| `#F1ECFD` | info strip | — |
| `#4C3A82` | info strip ink | — |
| `#EDE6FD` | hero wash ellipse | — |
| `#E8DEFC` | pill + icon button border | — |
| `#E0D4FA` | feature card border | — |
| `#E5484D` | messages badge | `State/Error #DC2626` |
| radius 22 | grouped list | `Radius/Card 20` |
| radius 24 | feature card | `Radius/Card 20` |
| radius 16 | info strip | `Radius/MD 14` |
| header 52 | every screen | `Size/Header-Height 56` |

Ten colours and four radii is a small enough list to reconcile in one pass —
worth doing before the remaining screens are built, so the drift does not
multiply across 247 of them.

## Screen anatomy

Every artboard follows the same skeleton, which is what made the widget set
fall out cleanly:

```
Screen 390×844  (vertical auto-layout)
├─ Status bar            47
├─ Header/Back           52   pad 8/24, 24px arrow at 1.75 stroke
├─ Body                  flex gap 28, pad 4/24/24/24
│   ├─ Head Block        gap 18
│   │   ├─ Page Icon Tile  40×40, r12, tint fill
│   │   └─ Head           gap 8 → Eyebrow 11 / H1 32 / Description 15
│   └─ Content           gap 14
│       ├─ Group/List    r22 → Card/Action (h98, pad 18) + Divider
│       └─ Info Strip    r16, tint fill
├─ Footnote              42   pad 8/24/16/24, icon 14 + label 13
└─ Home Indicator        34
```

Module home screens swap the header for a Circle Pill + round icon button, and
end in an 88px bottom navigation (58 items + 30 indicator).

## What is built

`lib/src/theme/` — colours (both themes), typography, layout, effects, ThemeData
`lib/src/widgets/` — PageIconTile, SmasherLabel, HeadBlock, InfoStrip, Footnote,
SmasherDivider, SmasherButton, SmasherInput, BottomActionBar, RoundIconButton,
BackHeader, GroupList, ActionCard, FeatureCard, CirclePill, SmasherBottomNav,
ScreenScaffold
`lib/src/screens/circle_entry_screen.dart` — P02 01 rebuilt from those widgets
`lib/main.dart` — component gallery with a light/dark toggle

## Verified against renders

Layer structure alone is not enough — the render is the source of truth. Every
screen below has been compared against `get_screenshot` output, not just the
node dump:

| Screen | Corrections applied |
|---|---|
| P02 20 Together | H1 is 36 not 32; hero gradient has three stops; eyebrow is a chip; tiles carry no headline number; Idea Deck card is violet-tinted; card titles are DM Sans; Together's nav glyph is two people, not a heart |
| P02 21 Profile | Wash sits higher (-300); settings rows use the deep tile |
| P02 02 Create Circle | Eyebrow is 11/14 Inter **Semi Bold** at +10% tracking, not Caption (11/16 Medium, +2%) — `SmasherText.eyebrow`; input Field Label is 13 **Medium** |
| P02 03 Invite People | Primary CTA is the brand GRADIENT `#8B5CF6 → #6D28D9`, not the flat brand token; "Skip for now" is a ghost button with `#52525E` ink; Group/List carries a 1px `#EDEDF3` outline |
| P02 04 QR Invitation | New `CodeCard` (r18, 1px `#EDEDF3`, pad 20, gap 16); secondary button is white + `#E6E6EE` border |
| P02 05 Invite Code | Same CodeCard, code set at H1 (DM Sans SemiBold 32) |
| P02 06 Circle Ready | Status layout: Body centred on both axes, 64px round `#EDE6FD` status tile, centred title block at gap 20, `CircleCard` with `InitialsAvatar` + `SmasherBadge` |
| P02 01 Circle Entry | Root fill is a vertical gradient `#EDE6FD → #F6F6F9`, now `SmasherGradient.screenWash` on `ScreenScaffold`; the action row's leading tile is the SOFT tint with a violet glyph, not the deep gradient — hence `ActionTone`; title is Inter Semi Bold 15 (`bodyStrong`), not Medium; chevron glyph is `#A1A1AE`, not Text/Secondary |

The bottom action bar is **transparent** with only a `#EDEDF3` top hairline —
it was painting white. h76 with one button, h134 with two at gap 6.

`ActionTone` is the important one: the same `Card/Action` component is drawn two
different ways in the file, and the setup flow's version (soft) is the default.

## Not done yet

Icons are Material placeholders. The Figma file has a dedicated Icons page with
custom vectors — those should be exported as SVGs and wired through
`flutter_svg` before any screen is considered final.

## Running it

```
flutter pub get
flutter run
```

Fonts come from `google_fonts` at runtime, so the first launch needs a network
connection. To ship offline, download DM Sans and Inter into `assets/fonts/`
and declare them in `pubspec.yaml` instead.
