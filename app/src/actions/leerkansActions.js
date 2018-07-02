export const LEERKANSEN_FETCH_LIST = 'gentlestudent/LEERKANSEN_FETCH_LIST';
export const LEERKANSEN_FETCH_LIST_SUCCES = 'gentlestudent/LEERKANSEN_FETCH_LIST_SUCCESS';
export const LEERKANSEN_FETCH_LIST_FAILED = 'gentlestudent/LEERKANSEN_FETCH_LIST_FAILED';
export const LEERKANSEN_CREATE_ITEM = 'gentlestudent/LEERKANSEN_CREATE_ITEM';
export const LEERKANSEN_CREATE_ITEM_SUCCES = 'gentlestudent/LEERKANSEN_CREATE_ITEM_SUCCESS';
export const LEERKANSEN_CREATE_ITEM_FAILED = 'gentlestudent/LEERKANSEN_CREATE_ITEM_FAILED';
export const LEERKANSEN_FETCH_BY_ID = 'gentlestudent/LEERKANSEN_FETCH_BY_ID';
export const LEERKANSEN_FETCH_BY_ID_SUCCES = 'gentlestudent/LEERKANSEN_FETCH_BY_ID_SUCCES';
export const LEERKANSEN_FETCH_BY_ID_FAILED = 'gentlestudent/LEERKANSEN_FETCH_BY_ID_FAILED';

// READ
export function LeerkansenFetch() {
	return {
		type: LEERKANSEN_FETCH_LIST
	}
}

// CREATE
export function LeerkansCreateItem(data) {
  return {
    type: LEERKANSEN_CREATE_ITEM,
    data
  };
}

export function LeerkansenFetchById(id) {
  return {
    type: LEERKANSEN_FETCH_BY_ID,
    id
  };
}
