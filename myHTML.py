#!/usr/bin/env python

"""
My module for HTML constructs
print_header(title="")
print_footer()
print_para(value)
"""

def print_header(title=""):
    """
    Print the HTML header, including body.
    print_header(title="")
    The title string is used in both the
    header title and a H1 title.
    """
    print "Content-Type: text/html\n"
    print "<html>\n"
    print "<head>\n"
    print "<title>%s</title>\n" % (title)
    print "</head>\n"
    print "<body>\n"
    print "<h1>%s</h1>\n" % (title)

def print_footer():
    print "</body>\n"
    print "</html>\n"

def print_para(value):
    print "<p>%s</p>\n" % (value)

def print_link(urlLnk, urlStr):
    print "<a href=\"%s\">%s</a>" % (urlLnk, urlStr)



if __name__ == "__main__":
    pass

