import re

def markup(source):
	block=re.compile(r'^\n?|\n{2,}')
	blocks=block.split(source)
	par=re.compile(r'[^>\s]')
	bquote=re.compile(r'>\s+(?=\S)')
	code=re.compile(r'\s+(?=\S)')
	new_blocks=[]
	for block in blocks:
		block_lines=block.split('\n')
		first=block_lines[0]
		if(par.match(first)):
			new_blocks.append('<p>'+block+'</p>')
		if(bquote.match(first)):
			indent=len(bquote.findall(first)[0])
			new_blocks.append('<blockquote>\n\n'+'\n'.join([bl[indent:] for bl in block_lines])+'</blockquote>')
		if(code.match(first)):
			indent=len(code.findall(first)[0])
			new_blocks.append('<pre><code>'+'\n'.join([bl[indent:] for bl in block_lines])+'</code></pre>')
	return '\n\n'.join(new_blocks)
			

txt="""> Разбира се това е проблемно при цитати
> > тук това се преобразува
> > това също
>
> > но това вече е вложен цитат понеже е отделен с празен
> > ред"""
print(markup(txt))



def markup_old(source):
	old_source=source

	par=re.compile(r'(^|\n{2,})([^>\s]((.|\n?.)+))')
	par.sub(r'\1<p>\2</p>\n',source)

	blockquote=re.compile(r'(^|\n{2,})>(\s+)(\S.+)(\n>\2(\S.+))*(?=\n{2,}|$)')
	bquotes=bquote.findall(c)
	for bquote in bquotes:
		fix=re.sub(r'(\n|^)>\s+',r'\n',bquote[0])
		re.sub(bquote[0], "\n<blockquote>"+fix+"</blockquote>", source)

	if(old_source!=source): return markup(source)
	return source
