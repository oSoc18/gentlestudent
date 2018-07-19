import React from 'react';

import { auth } from '../firebase';

import * as routes from '../../routes/routes'

const SignOutButton = () =>
  <a className="primary" href={routes.Login}
    onClick={auth.doSignOut}
  >
    Sign Out
  </a>

export default SignOutButton;