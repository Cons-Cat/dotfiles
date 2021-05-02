# Relative line numbers.
def switch-number-line -params .. %{
       try %{ remove-highlighter window/number_lines }
           add-highlighter window/number_lines number-lines %arg{@}
}

hook global NormalKey 0 'switch-number-line -relative'
hook global NormalKey \D.* 'switch-number-line'

# LSP
eval %sh{kak-lsp --kakoune -s $kak_session}
hook global WinSetOption filetype=(c|cpp|zig|glsl) %{
   lsp-enable-window
   lsp-auto-hover-enable
   lsp-auto-signature-help-enable
   lsp-auto-hover-insert-mode-disable
}

lsp-inlay-diagnostics-enable global

hook global WinSetOption filetype=<language> %{
 hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
 hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
 hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
 hook -once -always window WinSetOption filetype=.* %{
  remove-hooks window semantic-tokens
 }
}

# configure zls: we enable zig fmt, reference and semantic highlighting
hook global WinSetOption filetype=zig %{
 set-option buffer formatcmd 'zig fmt'
 set-option window lsp_auto_highlight_references true
 set-option global lsp_server_configuration zls.zig_lib_path="/usr/lib/zig"
 set-option -add global lsp_server_configuration zls.warn_style=true
 set-option -add global lsp_server_configuration zls.enable_semantic_tokens=true
 hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
 hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
 hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
 hook -once -always window WinSetOption filetype=.* %{
  remove-hooks window semantic-tokens
 }
}

hook global WinSetOption filetype=v %{
 set-option buffer formatcmd 'v fmt -w'
}

hook global WinSetOption filetype=glsl %{
 set-option window lsp_auto_highlight_references true
 hook window -group semantic-tokens BufReload .* lsp-semantic-tokens
 hook window -group semantic-tokens NormalIdle .* lsp-semantic-tokens
 hook window -group semantic-tokens InsertIdle .* lsp-semantic-tokens
 hook -once -always window WinSetOption filetype=.* %{
  remove-hooks window semantic-tokens
 }
}

def -hidden insert-c-n %{
    try %{
          lsp-snippets-select-next-placeholders
             exec '<a-;>d'
    } catch %{
          exec -with-hooks '<c-n>'
    }
}

map global insert <c-n> "<a-;>: insert-c-n<ret>"
map global user l %{: enter-user-mode lsp<ret>} -docstring "LSP mode"

def suspend-and-resume \
    -params 1..2 \
    -docstring 'suspend-and-resume <cli command> [<kak command after resume>]: backgrounds current kakoune client and runs specified cli command.  Upon exit of command the optional kak command is executed.' \
    %{ evaluate-commands %sh{

    # Note we are adding '&& fg' which resumes the kakoune client process after the cli command exits
    cli_cmd="$1 && fg"
    post_resume_cmd="$2"

    # automation is different platform to platform
    platform=$(uname -s)
    case $platform in
        Darwin)
            automate_cmd="sleep 0.01; osascript -e 'tell application \"System Events\" to keystroke \"$cli_cmd\" & return '"
            kill_cmd="/bin/kill"
            break
            ;;
        Linux)
            automate_cmd="sleep 0.2; xdotool type '$cli_cmd'; xdotool key Return"
            kill_cmd="/usr/bin/kill"
            break
            ;;
    esac

    # Uses platforms automation to schedule the typing of our cli command
    nohup sh -c "$automate_cmd"  > /dev/null 2>&1 &
    # Send kakoune client to the background
    $kill_cmd -SIGTSTP $kak_client_pid

    # ...At this point the kakoune client is paused until the " && fg " gets run in the $automate_cmd

    # Upon resume, run the kak command is specified
    if [ ! -z "$post_resume_cmd" ]; then
        echo "$post_resume_cmd"
    fi
}}

def for-each-line \
    -docstring "for-each-line <command> <path to file>: run command with the value of each line in the file" \
    -params 2 \
    %{ evaluate-commands %sh{

    while read f; do
        printf "$1 $f\n"
    done < "$2"
}}

def toggle-ranger %{
    suspend-and-resume \
        "ranger --choosefiles=/tmp/ranger-files-%val{client_pid}" \
        "for-each-line edit /tmp/ranger-files-%val{client_pid}"
}

map global user r ': toggle-ranger<ret>' -docstring 'select files in ranger'
