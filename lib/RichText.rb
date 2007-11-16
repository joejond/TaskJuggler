#
# RichText.rb - The TaskJuggler3 Project Management Software
#
# Copyright (c) 2006, 2007 by Chris Schlaeger <cs@kde.org>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of version 2 of the GNU General Public License as
# published by the Free Software Foundation.
#

require 'RichTextElement'
require 'RichTextParser'

# This class can process a string that contains text with MediaWiki type
# markups and convert this into plain strings or HTML elements.
#
# This class supports the following mark-ups:
#
# The following markups are block commands and must start at the beginning of
# the line.
#
# == Headline 1 ==
# === Headline 2 ===
# ==== Headline 3 ====
#
# * Bullet 1
# ** Bullet 2
# *** Bullet 3
#
# # Enumeration Level 1
# ## Enumeration Level 2
# ### Enumeration Level 3
#
#  Preformatted text start with
#  a single space at the start of the
#  the line.
#
#
# The following are in-line mark-ups and can occur within any text block
#
# This is an ''italic'' word.
# This is a '''bold''' word.
# This is a ''''monospaced'''' word.
# This is a '''''italic and bold''''' word.
#
# Linebreaks are ignored if not followed by a blank line.
#
# [http://www.taskjuggler.org] A web link
# [http://www.taskjuggler.org The TaskJuggler Web Site] another link
#
# [[item]] site internal internal reference (in HTML .html gets appended
#                                            automatically)
# [[item An item]] another internal reference
#
# <nowiki> ... </nowiki> Disable markup interpretation for portion of text.
#
class RichText

  attr_accessor :sectionNumbers, :lineWidth

  # Create a rich text object by passing a String with markup elements to it.
  # _text_ must be plain text with MediaWiki compatible markup elements. In
  # case an error occurs, an exception of type TjException will be raised.
  def initialize(text)
    # Set this to false to disable automatically generated section numbers.
    @sectionNumbers = true
    # Set this to the width of your text area. Needed for horizonal lines.
    @lineWidth = 80
    parser = RichTextParser.new(self)
    parser.open(text)
    # Parse the input text and convert it to the intermediate representation.
    @richText = parser.parse('richtext').cleanUp
  end

  # Convert the rich text to plain ASCII text. All elements that can't be
  # represented easily in ASCII Strings are ommitted.
  def to_s
    @richText.to_s
  end

  # Convert the rich text to HTML elements.
  def to_html
    @richText.to_html
  end

  # Convert the rich text to an ASCII version with HTML like markup tags. This
  # is probably only usefull for the unit test.
  def to_tagged #:nodoc:
    @richText.to_tagged
  end

end

