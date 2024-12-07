return {
    'sphamba/smear-cursor.nvim',
    event = 'UIEnter',

    opts = {
        smear_between_neighbor_lines = false,

        -- Make it a little faster (taken from the example in the docs)
        stiffness = 0.85,
        trailing_stiffness = 0.6,
        distance_stop_animating = 0.5
    }
}
