## 0.0.1

- Initial release.
  - showKDialogWithLoadingMessage
  - showKDialogWithLoadingIndicator
  - showBottomAlertKDialog
  - showKDialogContent
  - showConfirmationKDialog
  - showAsyncProgressKDialog

## 0.0.2

- Fix showConfirmationKDialog and showBottomAlertKDialog response
  - response false by default
- Fix showConfirmationKDialog width when message is short

## 0.0.3

- Refactor
- Add options dialogs

## 0.1.0

- Improvements in the way objects are compared in the options dialog

## 0.1.1

- Fix result on options dialogs when cancel button is pressed, returns null now

## 1.0.0

- Stable version

## 0.1.2

- fix show sync dialog

## 0.1.3

- fix custom box dialog

## 0.2.0

- replace WillPopScope to PopScope

## 0.3.0

- add showConfirmationKDialogWithCallback

## 0.3.1

- fix loading context

## 0.4.0

- add support to set customs strings

## 0.4.1

- fix exports

## 0.5.0  
- **General**  
  - Refactored multiple functions for readability, efficiency, and security.  
  - Removed redundant code; improved `context.mounted` usage in dialogs.  
  - Optimized dialog logic to prevent overflow and enhance UX.  

- **Fixes in `showKDialogContent`**  
  - Prevented title overflow with `TextOverflow.ellipsis` and `Flexible`.  
  - `onSave` is now `Future<bool>`, closing only if it returns `true`.  
  - Fixed `titlePadding` (was `titlePading`).  
  - Removed unnecessary `SizedBox(width: double.maxFinite)`.  

- **Improvements in `showAsyncProgressKDialog`**  
  - Initialized `closeloader = () {};` to prevent errors if `doProcess()` fails.  
  - Verified `context.mounted` in critical points to avoid exceptions.  
  - Improved `retry` handling by storing it before checking `context.mounted`.  
  - Ensured the loading dialog closes before any `await` in `catch`.  

- **Renamed** `wrapAsyncAction` → `executeAsyncWithErrorDialog`  

- **Optimized `showConfirmationKDialogWithCallback`**  
  - Ensured `onConfirm()` runs only if `answer == true`.  
  - Direct return, removing unnecessary temp variables.  

- **Fixes in `showBasicOptionsKDialog`**  
  - Fixed `isSelected`, previously misdeclared as `void`.  
  - Used `toSet()` in `selectedOptions` to prevent duplicates and boost performance.  
  - Refactored search, removing unnecessary functions.  
