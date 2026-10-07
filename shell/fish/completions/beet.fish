
function __fish_beet_needs_command
    set cmd (commandline -opc)
    if test (count $cmd) -eq 1
        return 0
    end
    return 1
end

function __fish_beet_using_command
    set cmd (commandline -opc)
    set needle (count $cmd)
    if test $needle -gt 1
        if begin test $argv[1] = $cmd[2];
            and not contains -- $cmd[$needle] $FIELDS; end
                return 0
        end
    end
    return 1
end

function __fish_beet_use_extra
    set cmd (commandline -opc)
    set needle (count $cmd)
    if test $argv[2]  = $cmd[$needle]
        return 0
    end
    return 1
end

set CMDS completion config convert fetchart fields fish ? help imp im import ls list lyrics mod modify mv move rm remove replaygain stats upd up update version write

set FIELDS acoustid_fingerprint: acoustid_id: added: album: album_id: albumartist: albumartist_credit: albumartist_sort: albumartists: albumartists_credit: albumartists_sort: albumdisambig: albumstatus: albumtotal: albumtype: albumtypes: arrangers: arrangers_ids: artist: artist_credit: artist_sort: artists: artists_credit: artists_ids: artists_sort: artpath: asin: barcode: bitdepth: bitrate: bitrate_mode: bpm: catalognum: channels: comments: comp: composer_sort: composers: composers_ids: country: day: disc: discogs_albumid: discogs_artistid: discogs_labelid: disctitle: disctotal: encoder: encoder_info: encoder_settings: filesize: format: genres: grouping: has_cover_art: id: initial_key: isrc: label: language: length: lyricists: lyricists_ids: lyrics: mb_albumartistid: mb_albumartistids: mb_albumid: mb_artistid: mb_artistids: mb_releasegroupid: mb_releasetrackid: mb_trackid: mb_workid: media: month: mtime: original_day: original_month: original_year: path: r128_album_gain: r128_track_gain: release_group_title: releasegroupdisambig: remixers: remixers_ids: rg_album_gain: rg_album_peak: rg_track_gain: rg_track_peak: samplerate: script: singleton: style: subtitle: title: track: trackdisambig: tracktotal: work: work_disambig: year:


# ====== setup basic beet completion =====

complete -c beet -n '__fish_beet_needs_command' -l format-item -f -d 'print with custom format'
complete -c beet -n '__fish_beet_needs_command' -l format-album -f -d 'print with custom format'
complete -c beet -n '__fish_beet_needs_command' -s  l  -l library -F -r -d 'library database file to use'
complete -c beet -n '__fish_beet_needs_command' -s  d  -l directory -F -r -d 'destination music directory'
complete -c beet -n '__fish_beet_needs_command' -s  v  -l verbose -f -d 'print debugging information'
complete -c beet -n '__fish_beet_needs_command' -s  c  -l config -F -r -d 'path to configuration file'
complete -c beet -n '__fish_beet_needs_command' -s  h  -l help -f -d 'print this help message and exit'

# ====== setup field completion for subcommands =====

# ------ fieldsetups for completion -------
complete -c beet -n '__fish_beet_needs_command' -a completion -f -d 'print shell script that provides command line completion'
complete -c beet -n '__fish_beet_using_command completion' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for config -------
complete -c beet -n '__fish_beet_needs_command' -a config -f -d 'show or edit the user configuration'
complete -c beet -n '__fish_beet_using_command config' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for convert -------
complete -c beet -n '__fish_beet_needs_command' -a convert -f -d 'convert to external location'
complete -c beet -n '__fish_beet_using_command convert' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for fetchart -------
complete -c beet -n '__fish_beet_needs_command' -a fetchart -f -d 'download album art'
complete -c beet -n '__fish_beet_using_command fetchart' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for fields -------
complete -c beet -n '__fish_beet_needs_command' -a fields -f -d 'show fields available for queries and format strings'
complete -c beet -n '__fish_beet_using_command fields' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for fish -------
complete -c beet -n '__fish_beet_needs_command' -a fish -f -d 'generate Fish shell tab completions'
complete -c beet -n '__fish_beet_using_command fish' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for \? -------
complete -c beet -n '__fish_beet_needs_command' -a \? -f -d 'give detailed help on a specific sub-command'
complete -c beet -n '__fish_beet_using_command \?' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for help -------
complete -c beet -n '__fish_beet_needs_command' -a help -f -d 'give detailed help on a specific sub-command'
complete -c beet -n '__fish_beet_using_command help' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for imp -------
complete -c beet -n '__fish_beet_needs_command' -a imp -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command imp' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for im -------
complete -c beet -n '__fish_beet_needs_command' -a im -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command im' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for import -------
complete -c beet -n '__fish_beet_needs_command' -a import -f -d 'import new music'
complete -c beet -n '__fish_beet_using_command import' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for ls -------
complete -c beet -n '__fish_beet_needs_command' -a ls -f -d 'query the library'
complete -c beet -n '__fish_beet_using_command ls' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for list -------
complete -c beet -n '__fish_beet_needs_command' -a list -f -d 'query the library'
complete -c beet -n '__fish_beet_using_command list' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for lyrics -------
complete -c beet -n '__fish_beet_needs_command' -a lyrics -f -d 'fetch song lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for mod -------
complete -c beet -n '__fish_beet_needs_command' -a mod -f -d 'change metadata fields'
complete -c beet -n '__fish_beet_using_command mod' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for modify -------
complete -c beet -n '__fish_beet_needs_command' -a modify -f -d 'change metadata fields'
complete -c beet -n '__fish_beet_using_command modify' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for mv -------
complete -c beet -n '__fish_beet_needs_command' -a mv -f -d 'move or copy items'
complete -c beet -n '__fish_beet_using_command mv' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for move -------
complete -c beet -n '__fish_beet_needs_command' -a move -f -d 'move or copy items'
complete -c beet -n '__fish_beet_using_command move' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for rm -------
complete -c beet -n '__fish_beet_needs_command' -a rm -f -d 'remove matching items from the library'
complete -c beet -n '__fish_beet_using_command rm' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for remove -------
complete -c beet -n '__fish_beet_needs_command' -a remove -f -d 'remove matching items from the library'
complete -c beet -n '__fish_beet_using_command remove' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for replaygain -------
complete -c beet -n '__fish_beet_needs_command' -a replaygain -f -d 'analyze for ReplayGain'
complete -c beet -n '__fish_beet_using_command replaygain' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for stats -------
complete -c beet -n '__fish_beet_needs_command' -a stats -f -d 'show statistics about the library or a query'
complete -c beet -n '__fish_beet_using_command stats' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for upd -------
complete -c beet -n '__fish_beet_needs_command' -a upd -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command upd' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for up -------
complete -c beet -n '__fish_beet_needs_command' -a up -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command up' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for update -------
complete -c beet -n '__fish_beet_needs_command' -a update -f -d 'update the library'
complete -c beet -n '__fish_beet_using_command update' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for version -------
complete -c beet -n '__fish_beet_needs_command' -a version -f -d 'output version information'
complete -c beet -n '__fish_beet_using_command version' -a '$FIELDS' -d 'fieldname'

# ------ fieldsetups for write -------
complete -c beet -n '__fish_beet_needs_command' -a write -f -d 'write tag information to files'
complete -c beet -n '__fish_beet_using_command write' -a '$FIELDS' -d 'fieldname'



# ====== completions for completion =====
complete -c beet -n '__fish_beet_using_command completion' -s h -l help -d 'print help'



# ====== completions for config =====
complete -c beet -n '__fish_beet_using_command config' -s p -l paths -d 'show files that configuration was loaded from'
complete -c beet -n '__fish_beet_using_command config' -s e -l edit -d 'edit user configuration with $VISUAL (or $EDITOR)'
complete -c beet -n '__fish_beet_using_command config' -s d -l defaults -d 'include the default configuration'
complete -c beet -n '__fish_beet_using_command config' -s c -l clear -d 'do not redact sensitive fields'
complete -c beet -n '__fish_beet_using_command config' -s h -l help -d 'print help'



# ====== completions for convert =====
complete -c beet -n '__fish_beet_using_command convert' -s p -l pretend -d 'show actions but do nothing'
complete -c beet -n '__fish_beet_using_command convert' -r -s t -l threads -d 'change the number of threads, defaults to maximum available processors'
complete -c beet -n '__fish_beet_using_command convert' -s r -l refresh -d 'reconvert if original file is newer than converted file'
complete -c beet -n '__fish_beet_using_command convert' -s k -l keep-new -d 'keep only the converted and move the old files'
complete -c beet -n '__fish_beet_using_command convert' -r -s d -l dest -d 'set the destination directory'
complete -c beet -n '__fish_beet_using_command convert' -r -s f -l format -d 'set the target format of the tracks'
complete -c beet -n '__fish_beet_using_command convert' -s y -l yes -d 'do not ask for confirmation'
complete -c beet -n '__fish_beet_using_command convert' -s l -l link -d 'symlink files that do not need transcoding.'
complete -c beet -n '__fish_beet_using_command convert' -s H -l hardlink -d 'hardlink files that do not need transcoding. Overrides --link.'
complete -c beet -n '__fish_beet_using_command convert' -r -s m -l playlist -d 'create an m3u8 playlist file containing the converted files. The playlist file will be saved below the destination directory, thus PLAYLIST could be a file name or a relative path. To ensure a working playlist when transferred to a different computer, or opened from an external drive, relative paths pointing to media files will be used.'
complete -c beet -n '__fish_beet_using_command convert' -s F -l force -d 'force transcoding. Ignores no_convert, never_convert_lossy_files, and max_bitrate'
complete -c beet -n '__fish_beet_using_command convert' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command convert' -s h -l help -d 'print help'



# ====== completions for fetchart =====
complete -c beet -n '__fish_beet_using_command fetchart' -s f -l force -d 're-download art when already present'
complete -c beet -n '__fish_beet_using_command fetchart' -s q -l quiet -d 'quiet mode: do not output albums that already have artwork'
complete -c beet -n '__fish_beet_using_command fetchart' -s h -l help -d 'print help'



# ====== completions for fields =====
complete -c beet -n '__fish_beet_using_command fields' -s h -l help -d 'print help'



# ====== completions for fish =====
complete -c beet -n '__fish_beet_using_command fish' -s f -l noFields -d 'omit album/track field completions'
complete -c beet -n '__fish_beet_using_command fish' -r -s e -l extravalues -a 'album_id channels length comments composers_ids mb_trackid artists_ids lyricists albumartists_credit original_year mb_albumid discogs_artistid albumtypes tracktotal comp country track r128_track_gain mb_albumartistids discogs_labelid r128_album_gain id barcode month release_group_title albumtype encoder_settings original_month trackdisambig disc mb_artistid bitrate_mode releasegroupdisambig grouping mb_workid disctitle year encoder encoder_info remixers lyrics bpm arrangers artist_sort path style work albumdisambig discogs_albumid bitrate mb_artistids original_day albumartists mb_albumartistid albumstatus mb_releasetrackid label rg_album_peak initial_key language albumartist_credit lyricists_ids mb_releasegroupid artists_credit asin rg_track_gain artist_credit composers isrc samplerate work_disambig filesize singleton disctotal acoustid_id arrangers_ids bitdepth rg_album_gain media artists day rg_track_peak artpath has_cover_art script composer_sort acoustid_fingerprint albumartist_sort artists_sort albumartists_sort remixers_ids catalognum subtitle album artist genres mtime albumartist albumtotal title format added' -d 'include specified field *values* in completions'
complete -c beet -n '__fish_beet_using_command fish' -r -s o -l output -d 'where to save the script. default: ~/.config/fish/completions'
complete -c beet -n '__fish_beet_using_command fish' -s h -l help -d 'print help'



# ====== completions for \? =====
complete -c beet -n '__fish_beet_using_command \?' -s h -l help -d 'print help'



# ====== completions for help =====
complete -c beet -n '__fish_beet_using_command help' -s h -l help -d 'print help'



# ====== completions for imp =====
complete -c beet -n '__fish_beet_using_command imp' -s c -l copy -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command imp' -s C -l nocopy -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command imp' -s m -l move -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command imp' -s M -l nomove -d "don't move tracks into the library (overrides -m)"
complete -c beet -n '__fish_beet_using_command imp' -s w -l write -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command imp' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command imp' -s a -l autotag -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command imp' -s A -l noautotag -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command imp' -s p -l resume -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command imp' -s P -l noresume -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command imp' -s q -l quiet -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command imp' -r -l quiet-fallback -d 'decision in quiet mode when no strong match: skip or asis'
complete -c beet -n '__fish_beet_using_command imp' -r -s l -l log -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command imp' -s s -l singletons -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command imp' -s t -l timid -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command imp' -s L -l library -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command imp' -s i -l incremental -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command imp' -s I -l noincremental -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command imp' -s R -l incremental-skip-later -d 'do not record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command imp' -s r -l noincremental-skip-later -d 'record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command imp' -l from-scratch -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command imp' -l flat -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command imp' -s g -l group-albums -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command imp' -l pretend -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command imp' -r -s S -l search-id -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command imp' -r -l from-logfile -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command imp' -r -l set -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command imp' -s h -l help -d 'print help'



# ====== completions for im =====
complete -c beet -n '__fish_beet_using_command im' -s c -l copy -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command im' -s C -l nocopy -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command im' -s m -l move -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command im' -s M -l nomove -d "don't move tracks into the library (overrides -m)"
complete -c beet -n '__fish_beet_using_command im' -s w -l write -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command im' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command im' -s a -l autotag -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command im' -s A -l noautotag -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command im' -s p -l resume -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command im' -s P -l noresume -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command im' -s q -l quiet -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command im' -r -l quiet-fallback -d 'decision in quiet mode when no strong match: skip or asis'
complete -c beet -n '__fish_beet_using_command im' -r -s l -l log -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command im' -s s -l singletons -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command im' -s t -l timid -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command im' -s L -l library -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command im' -s i -l incremental -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command im' -s I -l noincremental -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command im' -s R -l incremental-skip-later -d 'do not record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command im' -s r -l noincremental-skip-later -d 'record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command im' -l from-scratch -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command im' -l flat -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command im' -s g -l group-albums -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command im' -l pretend -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command im' -r -s S -l search-id -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command im' -r -l from-logfile -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command im' -r -l set -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command im' -s h -l help -d 'print help'



# ====== completions for import =====
complete -c beet -n '__fish_beet_using_command import' -s c -l copy -d 'copy tracks into library directory (default)'
complete -c beet -n '__fish_beet_using_command import' -s C -l nocopy -d "don't copy tracks (opposite of -c)"
complete -c beet -n '__fish_beet_using_command import' -s m -l move -d 'move tracks into the library (overrides -c)'
complete -c beet -n '__fish_beet_using_command import' -s M -l nomove -d "don't move tracks into the library (overrides -m)"
complete -c beet -n '__fish_beet_using_command import' -s w -l write -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command import' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command import' -s a -l autotag -d 'infer tags for imported files (default)'
complete -c beet -n '__fish_beet_using_command import' -s A -l noautotag -d "don't infer tags for imported files (opposite of -a)"
complete -c beet -n '__fish_beet_using_command import' -s p -l resume -d 'resume importing if interrupted'
complete -c beet -n '__fish_beet_using_command import' -s P -l noresume -d 'do not try to resume importing'
complete -c beet -n '__fish_beet_using_command import' -s q -l quiet -d 'never prompt for input: skip albums instead'
complete -c beet -n '__fish_beet_using_command import' -r -l quiet-fallback -d 'decision in quiet mode when no strong match: skip or asis'
complete -c beet -n '__fish_beet_using_command import' -r -s l -l log -d 'file to log untaggable albums for later review'
complete -c beet -n '__fish_beet_using_command import' -s s -l singletons -d 'import individual tracks instead of full albums'
complete -c beet -n '__fish_beet_using_command import' -s t -l timid -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command import' -s L -l library -d 'retag items matching a query'
complete -c beet -n '__fish_beet_using_command import' -s i -l incremental -d 'skip already-imported directories'
complete -c beet -n '__fish_beet_using_command import' -s I -l noincremental -d 'do not skip already-imported directories'
complete -c beet -n '__fish_beet_using_command import' -s R -l incremental-skip-later -d 'do not record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command import' -s r -l noincremental-skip-later -d 'record skipped files during incremental import'
complete -c beet -n '__fish_beet_using_command import' -l from-scratch -d 'erase existing metadata before applying new metadata'
complete -c beet -n '__fish_beet_using_command import' -l flat -d 'import an entire tree as a single album'
complete -c beet -n '__fish_beet_using_command import' -s g -l group-albums -d 'group tracks in a folder into separate albums'
complete -c beet -n '__fish_beet_using_command import' -l pretend -d 'just print the files to import'
complete -c beet -n '__fish_beet_using_command import' -r -s S -l search-id -d 'restrict matching to a specific metadata backend ID'
complete -c beet -n '__fish_beet_using_command import' -r -l from-logfile -d 'read skipped paths from an existing logfile'
complete -c beet -n '__fish_beet_using_command import' -r -l set -d 'set the given fields to the supplied values'
complete -c beet -n '__fish_beet_using_command import' -s h -l help -d 'print help'



# ====== completions for ls =====
complete -c beet -n '__fish_beet_using_command ls' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command ls' -s p -l path -d 'print paths for matched items or albums'
complete -c beet -n '__fish_beet_using_command ls' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command ls' -r -s l -l limit -d 'limit query results'
complete -c beet -n '__fish_beet_using_command ls' -s h -l help -d 'print help'



# ====== completions for list =====
complete -c beet -n '__fish_beet_using_command list' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command list' -s p -l path -d 'print paths for matched items or albums'
complete -c beet -n '__fish_beet_using_command list' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command list' -r -s l -l limit -d 'limit query results'
complete -c beet -n '__fish_beet_using_command list' -s h -l help -d 'print help'



# ====== completions for lyrics =====
complete -c beet -n '__fish_beet_using_command lyrics' -s p -l print -d 'print lyrics to console'
complete -c beet -n '__fish_beet_using_command lyrics' -r -s r -l write-rest -d 'write lyrics to given directory as ReST files'
complete -c beet -n '__fish_beet_using_command lyrics' -s f -l force -d 'always re-download lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -l keep-synced -d 'skip items that already have synced lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -l no-keep-synced -d 'do not skip items that already have synced lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -s l -l local -d 'do not fetch missing lyrics'
complete -c beet -n '__fish_beet_using_command lyrics' -s h -l help -d 'print help'



# ====== completions for mod =====
complete -c beet -n '__fish_beet_using_command mod' -s m -l move -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command mod' -s M -l nomove -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command mod' -s w -l write -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command mod' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command mod' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command mod' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command mod' -s y -l yes -d 'skip confirmation'
complete -c beet -n '__fish_beet_using_command mod' -s I -l noinherit -d "when modifying albums, don't also change item data"
complete -c beet -n '__fish_beet_using_command mod' -s h -l help -d 'print help'



# ====== completions for modify =====
complete -c beet -n '__fish_beet_using_command modify' -s m -l move -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command modify' -s M -l nomove -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command modify' -s w -l write -d "write new metadata to files' tags (default)"
complete -c beet -n '__fish_beet_using_command modify' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command modify' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command modify' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command modify' -s y -l yes -d 'skip confirmation'
complete -c beet -n '__fish_beet_using_command modify' -s I -l noinherit -d "when modifying albums, don't also change item data"
complete -c beet -n '__fish_beet_using_command modify' -s h -l help -d 'print help'



# ====== completions for mv =====
complete -c beet -n '__fish_beet_using_command mv' -r -s d -l dest -d 'destination directory'
complete -c beet -n '__fish_beet_using_command mv' -s c -l copy -d 'copy instead of moving'
complete -c beet -n '__fish_beet_using_command mv' -s p -l pretend -d "show how files would be moved, but don't touch anything"
complete -c beet -n '__fish_beet_using_command mv' -s t -l timid -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command mv' -s e -l export -d 'copy without changing the database path'
complete -c beet -n '__fish_beet_using_command mv' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command mv' -s h -l help -d 'print help'



# ====== completions for move =====
complete -c beet -n '__fish_beet_using_command move' -r -s d -l dest -d 'destination directory'
complete -c beet -n '__fish_beet_using_command move' -s c -l copy -d 'copy instead of moving'
complete -c beet -n '__fish_beet_using_command move' -s p -l pretend -d "show how files would be moved, but don't touch anything"
complete -c beet -n '__fish_beet_using_command move' -s t -l timid -d 'always confirm all actions'
complete -c beet -n '__fish_beet_using_command move' -s e -l export -d 'copy without changing the database path'
complete -c beet -n '__fish_beet_using_command move' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command move' -s h -l help -d 'print help'



# ====== completions for rm =====
complete -c beet -n '__fish_beet_using_command rm' -s d -l delete -d 'also remove files from disk'
complete -c beet -n '__fish_beet_using_command rm' -s f -l force -d 'do not ask when removing items'
complete -c beet -n '__fish_beet_using_command rm' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command rm' -s h -l help -d 'print help'



# ====== completions for remove =====
complete -c beet -n '__fish_beet_using_command remove' -s d -l delete -d 'also remove files from disk'
complete -c beet -n '__fish_beet_using_command remove' -s f -l force -d 'do not ask when removing items'
complete -c beet -n '__fish_beet_using_command remove' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command remove' -s h -l help -d 'print help'



# ====== completions for replaygain =====
complete -c beet -n '__fish_beet_using_command replaygain' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command replaygain' -r -s t -l threads -d 'change the number of threads, defaults to maximum available processors'
complete -c beet -n '__fish_beet_using_command replaygain' -s f -l force -d 'analyze all files, including those that already have ReplayGain metadata'
complete -c beet -n '__fish_beet_using_command replaygain' -s w -l write -d "write new metadata to files' tags"
complete -c beet -n '__fish_beet_using_command replaygain' -s W -l nowrite -d "don't write metadata (opposite of -w)"
complete -c beet -n '__fish_beet_using_command replaygain' -s h -l help -d 'print help'



# ====== completions for stats =====
complete -c beet -n '__fish_beet_using_command stats' -s e -l exact -d 'exact size and time'
complete -c beet -n '__fish_beet_using_command stats' -s h -l help -d 'print help'



# ====== completions for upd =====
complete -c beet -n '__fish_beet_using_command upd' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command upd' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command upd' -s m -l move -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command upd' -s M -l nomove -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command upd' -s p -l pretend -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command upd' -r -s F -l field -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command upd' -r -s e -l exclude-field -d 'list of fields to exclude from updates'
complete -c beet -n '__fish_beet_using_command upd' -s h -l help -d 'print help'



# ====== completions for up =====
complete -c beet -n '__fish_beet_using_command up' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command up' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command up' -s m -l move -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command up' -s M -l nomove -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command up' -s p -l pretend -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command up' -r -s F -l field -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command up' -r -s e -l exclude-field -d 'list of fields to exclude from updates'
complete -c beet -n '__fish_beet_using_command up' -s h -l help -d 'print help'



# ====== completions for update =====
complete -c beet -n '__fish_beet_using_command update' -s a -l album -d 'match albums instead of tracks'
complete -c beet -n '__fish_beet_using_command update' -r -s f -l format -d 'print with custom format'
complete -c beet -n '__fish_beet_using_command update' -s m -l move -d 'move files in the library directory'
complete -c beet -n '__fish_beet_using_command update' -s M -l nomove -d "don't move files in library"
complete -c beet -n '__fish_beet_using_command update' -s p -l pretend -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command update' -r -s F -l field -d 'list of fields to update'
complete -c beet -n '__fish_beet_using_command update' -r -s e -l exclude-field -d 'list of fields to exclude from updates'
complete -c beet -n '__fish_beet_using_command update' -s h -l help -d 'print help'



# ====== completions for version =====
complete -c beet -n '__fish_beet_using_command version' -s h -l help -d 'print help'



# ====== completions for write =====
complete -c beet -n '__fish_beet_using_command write' -s p -l pretend -d 'show all changes but do nothing'
complete -c beet -n '__fish_beet_using_command write' -s f -l force -d 'write tags even if the existing tags match the database'
complete -c beet -n '__fish_beet_using_command write' -s h -l help -d 'print help'
