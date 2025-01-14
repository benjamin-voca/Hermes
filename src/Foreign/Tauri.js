"use strict";

import { invoke } from '@tauri-apps/api/core';

export const invoke_ = (command) => (args = {}) => (options = {}) => () =>
    invoke(command, args, options);
