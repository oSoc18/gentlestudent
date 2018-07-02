export const BADGE_FETCH_LIST = 'gentlestuent/BADGE_FETCH_LIST';
export const BADGE_FETCH_LIST_SUCCES = 'gentlestuent/BADGE_FETCH_LIST_SUCCES';
export const BADGE_FETCH_LIST_FAILED = 'gentlestuent/BADGE_FETCH_LIST_FAILED';

export const BADGE_ISSUE_RECIPIENT = 'gentlestuent/BADGE_ISSUE_RECIPIENT';
export const BADGE_ISSUE_RECIPIENT_SUCCES = 'gentlestuent/BADGE_ISSUE_RECIPIENT_SUCCES';
export const BADGE_ISSUE_RECIPIENT_FAILED = 'gentlestuent/BADGE_ISSUE_RECIPIENT_FAILED';

// ISSUE
export function BadgeIssueRecipient(data) {
  return {
    type: BADGE_ISSUE_RECIPIENT,
    data
  };
}

export function BadgeFetchList(data) {
  return {
    type: BADGE_FETCH_LIST,
    data
  };
}
