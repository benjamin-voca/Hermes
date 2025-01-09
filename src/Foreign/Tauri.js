import { invoke } from '@tauri-apps/api/core';

export const invokeTauriCommand = (command) => async (args) => {
    return await invoke(command, args);
};
