_: {
    programs.git = {
        enable = true;
        extraConfig = {
            commit.gpgSign = true;
            user.name = "Elliana Perry";
            user.email = "elliana.perry@gmail.com";
        };
    };
}