import React from 'react';

import { auth } from '../../../Utils/Firebase';

import * as routes from '../../../routes/routes'

const SignOutButton = () =>
  <a className="primary" href={routes.Login}
    onClick={auth.doSignOut}
  >
    Log uit
  </a>

export default SignOutButton;