class KDialogStrings {
  final String acceptButtonText;
  final String confirmButtonText;
  final String cancelButtonText;
  final String saveButtonText;
  final String confirmationMessage;
  final String errorRetryText;
  final String searchLabelInputText;
  final String bottomErrorAlertTitle;
  final String confirmDialogText;
  final String defaultDialogTitle;
  final String loadingDialogMessage;
  KDialogStrings({
    required this.acceptButtonText,
    required this.confirmButtonText,
    required this.cancelButtonText,
    required this.saveButtonText,
    required this.confirmationMessage,
    required this.errorRetryText,
    required this.searchLabelInputText,
    required this.bottomErrorAlertTitle,
    required this.confirmDialogText,
    required this.defaultDialogTitle,
    required this.loadingDialogMessage,
  });
}

KDialogStrings strings = KDialogStrings(
  acceptButtonText: "ACCEPT",
  confirmButtonText: "CONFIRM",
  cancelButtonText: "CANCEL",
  saveButtonText: "Save",
  confirmationMessage: "Are you sure you want to proceed with this operation?",
  errorRetryText: "RETRY",
  searchLabelInputText: "Search",
  bottomErrorAlertTitle: 'Error, Something was wrong...',
  confirmDialogText: "Before proceeding, Please confirm this action.",
  defaultDialogTitle: "Title!",
  loadingDialogMessage: "Loading Please Wait...",
);
void setKDialogStrings(KDialogStrings value) => strings = value;
