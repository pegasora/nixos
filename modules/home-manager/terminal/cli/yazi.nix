{
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
    #enableNushellIntegration = true;

    keymap.mgr.prepend_keymap = [
      {
        on = ["Q"];
        run = "quit";
      }
      {
        on = ["q"];
        run = "quit --no-cwd-file";
      }
    ];

    settings = {
      mgr = {
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
        show_hidden = true;
      };
    };

    theme = {
      # ────────────────────────────────────────────────
      # New Kanagawa theme
      # ────────────────────────────────────────────────

      mgr = {
        marker_copied = {
          fg = "#98bb6c";
          bg = "#98bb6c";
        };
        marker_cut = {
          fg = "#e46876";
          bg = "#e46876";
        };
        marker_marked = {
          fg = "#957fb8";
          bg = "#957fb8";
        };
        marker_selected = {
          fg = "#ffa066";
          bg = "#ffa066";
        };

        cwd = {fg = "#e6c384";};

        find_keyword = {
          fg = "#ffa066";
          bg = "#1f1f28";
        };
        find_position = {};

        count_copied = {
          fg = "#1f1f28";
          bg = "#98bb6c";
        };
        count_cut = {
          fg = "#1f1f28";
          bg = "#e46876";
        };
        count_selected = {
          fg = "#1f1f28";
          bg = "#ffa066";
        };

        border_symbol = "│";
        border_style = {fg = "#dcd7ba";};
      };

      indicator = {
        parent = {reversed = true;};
        current = {reversed = true;};
        preview = {reversed = true;};
      };

      tabs = {
        active = {
          fg = "#1f1f28";
          bg = "#7e9cd8";
        };
        inactive = {
          fg = "#7e9cd8";
          bg = "#2a2a37";
        };
        sep_inner = {
          open = "";
          close = "";
        };
        sep_outer = {
          open = "";
          close = "";
        };
      };

      mode = {
        normal_main = {
          fg = "#1f1f28";
          bg = "#7e9cd8";
        };
        normal_alt = {
          fg = "#7e9cd8";
          bg = "#2a2a37";
        };
        select_main = {
          fg = "#1f1f28";
          bg = "#957fb8";
        };
        select_alt = {
          fg = "#957fb8";
          bg = "#2a2a37";
        };
        unset_main = {
          fg = "#1f1f28";
          bg = "#e6c384";
        };
        unset_alt = {
          fg = "#e6c384";
          bg = "#2a2a37";
        };
      };

      status = {
        sep_left = {
          open = "";
          close = "";
        };
        sep_right = {
          open = "";
          close = "";
        };
        overall = {
          fg = "#c8c093";
          bg = "#16161d";
        };
        progress_label = {
          fg = "#7e9cd8";
          bold = true;
        };
        progress_normal = {
          fg = "#2a2a37";
          bg = "#1f1f28";
        };
        progress_error = {
          fg = "#2a2a37";
          bg = "#1f1f28";
        };
        perm_type = {fg = "#98bb6c";};
        perm_read = {fg = "#e6c384";};
        perm_write = {fg = "#ff5d62";};
        perm_exec = {fg = "#7aa89f";};
        perm_sep = {fg = "#957fb8";};
      };

      pick = {
        border = {fg = "#7fb4ca";};
        active = {
          fg = "#957fb8";
          bold = true;
        };
        inactive = {};
      };

      input = {
        border = {fg = "#7fb4ca";};
        title = {};
        value = {};
        selected = {reversed = true;};
      };

      completion = {
        border = {fg = "#7fb4ca";};
        active = {reversed = true;};
        inactive = {};
      };

      tasks = {
        border = {fg = "#7fb4ca";};
        title = {};
        hovered = {fg = "#957fb8";};
      };

      which = {
        cols = 2;
        separator = " - ";
        separator_style = {fg = "#727169";};
        mask = {bg = "#16161d";};
        rest = {fg = "#727169";};
        cand = {fg = "#7e9cd8";};
        desc = {fg = "#54546d";};
      };

      help = {
        on = {fg = "#7aa89f";};
        run = {fg = "#957fb8";};
        desc = {};
        hovered = {
          reversed = true;
          bold = true;
        };
        footer = {
          fg = "#1f1f28";
          bg = "#dcd7ba";
        };
      };

      notify = {
        title_info = {fg = "#98bb6c";};
        title_warn = {fg = "#e6c384";};
        title_error = {fg = "#ff5d62";};
      };

      filetype = {
        rules = [
          # images
          {
            mime = "image/*";
            fg = "#e6c384";
          }
          # media
          {
            mime = "{audio,video}/*";
            fg = "#957fb8";
          }
          # archives
          {
            mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}";
            fg = "#e46876";
          }
          # documents
          {
            mime = "application/{pdf,doc,rtf,vnd.*}";
            fg = "#6a9589";
          }
          # broken links
          {
            url = "*";
            is = "orphan";
            fg = "#c34043";
          }
          # executables
          {
            url = "*";
            is = "exec";
            fg = "#76946a";
          }
          # fallback
          {
            url = "*";
            fg = "#dcd7ba";
          }
          {
            url = "*/";
            fg = "#7e9cd8";
          }
        ];
      };

      # ────────────────────────────────────────────────
      # Old Catppuccin theme (commented out)
      # ────────────────────────────────────────────────
      #      /*
      #      mgr = {
      #        cwd = { fg = "#94e2d5"; };
      #        hovered = { fg = "#1e1e2e"; bg = "#89b4fa"; };
      #        preview_hovered = { fg = "#1e1e2e"; bg = "#cdd6f4"; };
      #        find_keyword = { fg = "#f9e2af"; italic = true; };
      #        find_position = { fg = "#f5c2e7"; bg = "reset"; italic = true; };
      #        marker_copied = { fg = "#a6e3a1"; bg = "#a6e3a1"; };
      #        marker_cut = { fg = "#f38ba8"; bg = "#f38ba8"; };
      #        marker_marked = { fg = "#94e2d5"; bg = "#94e2d5"; };
      #        marker_selected = { fg = "#89b4fa"; bg = "#89b4fa"; };
      #        count_copied = { fg = "#1e1e2e"; bg = "#a6e3a1"; };
      #        count_cut = { fg = "#1e1e2e"; bg = "#f38ba8"; };
      #        count_selected = { fg = "#1e1e2e"; bg = "#89b4fa"; };
      #        border_symbol = "│";
      #        border_style = { fg = "#7f849c"; };
      #        syntect_theme = "~/.config/yazi/Catppuccin-mocha.tmTheme";
      #      };
      #      tabs = {
      #        active = { fg = "#1e1e2e"; bg = "#cdd6f4"; bold = true; };
      #        inactive = { fg = "#cdd6f4"; bg = "#45475a"; };
      #      };
      #      mode = {
      #        normal_main = { fg = "#1e1e2e"; bg = "#89b4fa"; bold = true; };
      #        normal_alt = { fg = "#89b4fa"; bg = "#313244"; };
      #        select_main = { fg = "#1e1e2e"; bg = "#a6e3a1"; bold = true; };
      #        select_alt = { fg = "#a6e3a1"; bg = "#313244"; };
      #        unset_main = { fg = "#1e1e2e"; bg = "#f2cdcd"; bold = true; };
      #        unset_alt = { fg = "#f2cdcd"; bg = "#313244"; };
      #      };
      #      status = {
      #        separator_open = "";
      #        separator_close = "";
      #        progress_label = { fg = "#ffffff"; bold = true; };
      #        progress_normal = { fg = "#89b4fa"; bg = "#45475a"; };
      #        progress_error = { fg = "#f38ba8"; bg = "#45475a"; };
      #        perm_type = { fg = "#89b4fa"; };
      #        perm_read = { fg = "#f9e2af"; };
      #        perm_write = { fg = "#f38ba8"; };
      #        perm_exec = { fg = "#a6e3a1"; };
      #        perm_sep = { fg = "#7f849c"; };
      #      };
      #      # ... (rest of old theme)
      #      filetype.rules = [
      #        { mime = "image/*"; fg = "#94e2d5"; }
      #        { mime = "{audio,video}/*"; fg = "#f9e2af"; }
      #        { mime = "application/*zip"; fg = "#f5c2e7"; }
      #        { mime = "application/x-{tar,bzip*,7z-compressed,xz,rar}"; fg = "#f5c2e7"; }
      #        { mime = "application/{pdf,doc,rtf}"; fg = "#a6e3a1"; }
      #        { name = "*"; fg = "#cdd6f4"; }
      #        { name = "*/"; fg = "#89b4fa"; }
      #      ];
      #      */
    };
  };
}
