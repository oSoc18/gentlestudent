export const BADGE_ISSUE_RECIPIENT = 'gentlestuent/BADGE_ISSUE_RECIPIENT';
export const BADGE_ISSUE_RECIPIENT_SUCCES = 'gentlestuent/BADGE_ISSUE_RECIPIENT_SUCCESS';
export const BADGE_ISSUE_RECIPIENT_FAILED = 'gentlestuent/BADGE_ISSUE_RECIPIENT_FAILED';

// ISSUE
export function BadgeIssueRecipient(data) {
  return {
    type: BADGE_ISSUE_RECIPIENT,
    data
  };
}
