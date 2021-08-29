<center><h2>Hello Markdown</h2></center>

#  H1
##  H2
###  H3
####  H4
#####  H5
######  H6

---

另外，H1和H2还能用以下方式显示：

一级标题
===
 
二级标题
---

---

*斜体* or _强调_
**加粗** or __加粗__
***粗斜体*** or __粗斜体__

---

* 无序列表
* 子项
* 子项
 
+ 无序列表
+ 子项
+ 子项
 
- 无序列表
- 子项
- 子项

---

Ordered 有序列表：

1. 第一行
2. 第二行
3. 第三行
---
1. 第一行
- 第二行
- 第三行

---

组合：

* 产品介绍（子项无项目符号）
    此时子项，要以一个制表符或者4个空格缩进
 
* 产品特点
    1. 特点1
    - 特点2
    - 特点3
* 产品功能
    1. 功能1
    - 功能2
    - 功能3

---

Links 连接（title为可选项）：

[W3Cschool](http://www.w3cschool.cn/ "W3Cschool")

[链接文字][id]
[id]: http://www.w3cschool.cn/ "标题文字"

[链接文字](../path/file/readme.text "标题文字")

[链接文字][]
[链接文字]: http://www.w3cschool.cn/

---

<example@w3cschool.cn>

---

![替代文字](http://statics.w3cschool.cn/images/w3c/index-logo.png "标题文字")

![替代文字][logo]
[logo]: http://statics.w3cschool.cn/images/w3c/index-logo.png "标题文字"


---

```html
    <div>Syntax Highlighting</div>
```

```css
    body{font-size:12px}
```

```javascript
    var s = "JavaScript syntax highlighting";
    alert(s);
```

```php
    <?php
      echo "hello, world!";
    ?>
```

```python
    s = "Python syntax highlighting"
    print s
```

---

> Email-style angle brackets
> are used for blockquotes.
> > And, they can be nested.
> #### Headers in blockquotes
> * You can quote a list.
> * Etc.

---

在一行的结尾处加上2个或2个以上的空格，也可以使用</br>标签
第一行文字，
第二行文字


***
* * *
- - -

\*literal asterisks\*

---

\反斜杠  
`反引号  
*星号  
_下划线  
{}花括号  
[]方括号  
()括弧  
#井字号  
+加号  
-减号  
.英文句 
!感叹号

---

Markdown也支持传统的HTML标签。

比如一个链接，你不太喜欢Markdown的写法，也可以直接写成

<a href="https://www.w3cschool.cn/">W3Cschool</a>