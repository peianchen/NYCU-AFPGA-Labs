"""Check curated documents and accidental raw-report inclusion (standard library)."""
from pathlib import Path
import re
import subprocess
from urllib.parse import unquote, urlsplit

root = Path(__file__).resolve().parents[1]
files = [root / name for name in subprocess.check_output(['git','ls-files'],cwd=root,text=True,encoding='utf-8').splitlines()]
assert files, 'Stage the proposed publication before checking.'
for path in files:
    assert path.suffix.lower() not in {'.doc','.docx','.pdf','.exe','.bundle','.zip'}, path
    assert not any(part in {'reports','.planning','db','incremental_db'} for part in path.relative_to(root).parts), path
    if path.suffix.lower() in {'.jpg','.jpeg','.png'}:
        continue
    text=path.read_text(encoding='utf-8',errors='replace')
    assert not re.search(r'[A-Z]:[/\\]Users[/\\]',text,re.I),path
    assert not re.search(r'(?:ghp_|github_pat_)[A-Za-z0-9_]{20,}|-----BEGIN (?:RSA |OPENSSH )?PRIVATE KEY-----',text),path
    if path.suffix=='.md':
        prose=re.sub(r'```.*?```','',text,flags=re.S)
        for target in re.findall(r'!?\[[^\]]*\]\(([^)]+)\)',prose):
            parts=urlsplit(target)
            if parts.scheme or parts.netloc or not parts.path: continue
            assert (path.parent / unquote(parts.path)).resolve().exists(),(path,target)
for number in range(1,9):
    path=root/f'labs/lab{number:02}/README.md'
    text=path.read_text(encoding='utf-8')
    assert '目的' in text and '結果' in text and ('限制' in text or '分析' in text),path
print(f'Publication checks passed: {len(files)} tracked files; 8 documented labs.')
