export const LEERKANSEN_FETCH_LIST = 'gentlestudent/LEERKANSEN_FETCH_LIST';
export const LEERKANSEN_FETCH_LIST_SUCCES = 'gentlestudent/LEERKANSEN_FETCH_LIST_SUCCESS';
export const LEERKANSEN_FETCH_LIST_FAILED = 'gentlestudent/LEERKANSEN_FETCH_LIST_FAILED';

export const LEERKANSEN_CREATE_ITEM = 'gentlestudent/LEERKANSEN_CREATE_ITEM';
export const LEERKANSEN_CREATE_ITEM_SUCCES = 'gentlestudent/LEERKANSEN_CREATE_ITEM_SUCCESS';
export const LEERKANSEN_CREATE_ITEM_FAILED = 'gentlestudent/LEERKANSEN_CREATE_ITEM_FAILED';

export const LEERKANSEN_FETCH_BY_ID = 'gentlestudent/LEERKANSEN_FETCH_BY_ID';
export const LEERKANSEN_FETCH_BY_ID_SUCCES = 'gentlestudent/LEERKANSEN_FETCH_BY_ID_SUCCES';
export const LEERKANSEN_FETCH_BY_ID_FAILED = 'gentlestudent/LEERKANSEN_FETCH_BY_ID_FAILED';

export const LEERKANSEN_DELETE_ITEM = 'gentlestudent/LEERKANSEN_DELETE_ITEM';
export const LEERKANSEN_DELETE_ITEM_SUCCES = 'gentlestudent/LEERKANSEN_DELETE_ITEM_SUCCES';
export const LEERKANSEN_DELETE_ITEM_FAILED = 'gentlestudent/LEERKANSEN_DELETE_ITEM_FAILED';

// READ
export function LeerkansenFetch() {
	return {
		type: LEERKANSEN_FETCH_LIST
	}
}
export function LeerkansenFetchById(id) {
  return {
    type: LEERKANSEN_FETCH_BY_ID,
    id
  };
}

// CREATE
export function LeerkansCreateItem(data) {
  return {
    type: LEERKANSEN_CREATE_ITEM,
    data
  };
}

// DELETE
export function LeerkansenDeleteItem(data) {
  return {
    type: LEERKANSEN_DELETE_ITEM,
    data
  };
}
