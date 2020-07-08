# Postgres CJK Parser - pg_cjk_parser

此库升级Postgres版本为12，文档对在Docker容器中手动安装进行了说明。[查看源库](https://github.com/huangjimmy/pg_cjk_parser)

## 说明

当数据库使用utf-8编码时pg_cjk_parser对中、日、韩语言提供了文本搜索功能且支持默认解析器的所有功能，如果不是utf-8编码则使用默认解析器。工作方式为将语句切成2个字的词，例如：

```sql
SELECT alias, description, token FROM 
ts_debug('你好中国，武汉挺住！こんにちは日本。안녕하세요한국。Hello world!');
```
> 日语韩语是机翻的，测试发现韩语无法切分，不知道什么原因。

## 编译安装

1. [下载源码](https://github.com/huangjimmy/pg_cjk_parser/archive/master.zip)，解压进入源码文件夹；
2. 创建镜像：`$ docker build -t postgres:12-dev .`；
3. 编译库：`$ docker run -it --rm -v $(PWD):/root/code postgres:12-dev /bin/bash -c "cd /root/code && make"`
4. 运行Postgres 12容器，容器名称**postgres**；
5. 复制库到运行Postgres容器中：`$ docker cp pg_cjk_parser.so postgres:/usr/lib/postgresql/12/lib/`；
6. 使用[pgadmin4](https://hub.docker.com/r/dpage/pgadmin4)或其它数据库客户端连接数据库，执行[docker.sql](docker.sql)中的脚本。

执行下面脚本测试：

```sql
select to_tsvector('你好中国，武汉挺住！こんにちは日本。안녕하세요한국。Hello world!') @@ to_tsquery('你好 & 武汉');
```

## 示例

### 权重

数值越大权重越高，匹配越多数值越大。

```sql
select ts_rank(to_tsvector('你好中国，武汉挺住！'), to_tsquery('你好'));
```
> 0.06079271

```sql
select ts_rank(to_tsvector('你好中国，武汉你好！'), to_tsquery('你好'));
```
> 0.075990885

## License

### PG CJK Parser

PG_CJK Parser is a derived work based on PostgreSQL source code 'src/backend/tsearch/wparser_def.c'.
The license of this derived work is the same as that of PostgreSQL source code.

### PostgreSQL

PostgreSQL Database Management System
(formerly known as Postgres, then as Postgres95)

Portions Copyright (c) 1996-2019, PostgreSQL Global Development Group

Portions Copyright (c) 1994, The Regents of the University of California

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose, without fee, and without a written agreement
is hereby granted, provided that the above copyright notice and this
paragraph and the following two paragraphs appear in all copies.

IN NO EVENT SHALL THE UNIVERSITY OF CALIFORNIA BE LIABLE TO ANY PARTY FOR
DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES, INCLUDING
LOST PROFITS, ARISING OUT OF THE USE OF THIS SOFTWARE AND ITS
DOCUMENTATION, EVEN IF THE UNIVERSITY OF CALIFORNIA HAS BEEN ADVISED OF THE
POSSIBILITY OF SUCH DAMAGE.

THE UNIVERSITY OF CALIFORNIA SPECIFICALLY DISCLAIMS ANY WARRANTIES,
INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY
AND FITNESS FOR A PARTICULAR PURPOSE.  THE SOFTWARE PROVIDED HEREUNDER IS
ON AN "AS IS" BASIS, AND THE UNIVERSITY OF CALIFORNIA HAS NO OBLIGATIONS TO
PROVIDE MAINTENANCE, SUPPORT, UPDATES, ENHANCEMENTS, OR MODIFICATIONS.

### PostgreSQL Docker

Copyright (c) 2014, Docker PostgreSQL Authors (See AUTHORS)

Permission is hereby granted, free of charge, to any person
obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without
restriction, including without limitation the rights to use,
copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following
conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.
