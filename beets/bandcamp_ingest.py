'''Import downloaded zip files from bandcamp with beets.'''
import os
from pathlib import Path
import re
import sys
import zipfile


def main():
    import_dir = Path('.')
    if len(sys.argv) > 1:
        import_dir = Path(sys.argv[1])
        assert import_dir.is_dir()

    file_matcher = re.compile(r'^(.+? - .+?)\.zip$')
    for file in import_dir.iterdir():
        match = file_matcher.match(str(file))
        if match:
            dir_name = match.group(1)
            os.makedirs(import_dir / dir_name)
            file = file.rename(import_dir / dir_name / file)
            with zipfile.ZipFile(file) as zip_file:
                zip_file.extractall(import_dir / dir_name)

    print(f'Now run `beet import {import_dir}`')


if __name__ == "__main__":
    sys.exit(main())
