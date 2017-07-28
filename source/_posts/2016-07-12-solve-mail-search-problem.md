title: Solve Searching Problem in Mac's Mail
date: 2016-07-12 10:30:00 +0800
categories:
 - technologies
tags:
 - Mac
 - mail
author: Kevin
---

Even when you know the basics of searching in Mac's Mail, sometimes an email message you clearly remember stubbornly stays lost. 

If a Mail search doesn’t display messages that you know it should - and you’ve ruled out user error such as selecting the wrong mailbox, or choosing a header instead of message contents—there are several possible causes. Which solution to use depends on whether errors occur searching message contents (the body of your message) or headers (the contents of the To, CC, BCC, From, and Subject fields).

<!-- more -->

## Problems searching headers

When you type a term into Mail’s Search field, you can optionally select a person, subject, or other category from a pop-up menu to create a token that Mail uses to search one or more headers alone (such as To, From, and Subject). (If you don’t explicitly select a header, or if you do but change the search token to say Entire Message, Mail searches message bodies as well as headers.) Surprisingly, Mail’s system for indexing and searching headers is separate from its system for indexing and searching message contents, so searching for header text (say, messages from a certain co-worker) could fail even if the same message is matched during a search of its contents.

Mail uses a set of files collectively called the Envelope Index to index and search message headers. So, if you’re unable to find messages when searching headers, there’s a good chance the Envelope Index is having problems. The surest solution is to force Mail to rebuild the entire Envelope Index.

To do this, first quit Mail. Then, in the Finder, hold down Option and choose Go -> Library. Navigate to ~/Library/Mail/V2/MailData and drag the following files to the Trash: Envelope Index, Envelope Index-shm, and Envelope Index-wal. Open Mail again, and you’ll see a message that Mail has to import your messages. Click Continue and let it do so; what it’s really doing is rebuilding your Envelope Index. When this process finishes, try your search again.

![envelopeindex.jpg](/images/posts/mac/envelopeindex.jpg)

If Mail fails to find the right messages when you search for words in the To, From, or Subject field, a bad Envelope Index could be to blame. If you need to delete your envelope index, these are the files to select.


## Problems searching message contents

On the other hand, suppose you stick with the Entire Message option to look for words in the contents of message bodies, because you aren’t sure who sent the message or when, or because the number of matches using headers alone is too great. Searching for unusual, specific keywords you remember from the message (“furlong,” “fortnight”) or entire phrases ("lost in the mists of time") can often lead you right to the message you want—unless full-text searching happens to be broken.

Mail uses OS X’s Spotlight feature to index and search the contents of messages, so if you have trouble with searching message contents, the most likely cause is a problem with your Spotlight index. Try the following potential cures, in this order, retrying your search after each until you’re successful:

**Check for privacy problems** Open the Spotlight pane of System Preferences, go to the Privacy tab, and make sure it doesn’t show your ~/Library/Mail folder or any of its parent folders (such as your entire home folder) or the volume on which it’s located. If it does, select that folder or volume and click the minus (-) button to allow Spotlight to index it (which may take some time).

**Tweak settings** For server-based accounts (IMAP, Exchange, iCloud, and MobileMe), make sure Mail is set to download entire messages—if it doesn’t, Spotlight can’t index them. Go to Mail -> Preferences, click Accounts, select an account, and click Advanced. Make sure the Keep Copies Of Messages For Offline Viewing pop-up menu says All Messages And Their Attachments.

![downloadall.jpg](/images/posts/mac/downloadall.jpg)

For every server-based account, go to this preference pane and make sure this pop-up menu is set to one of the "All Messages" options (preferably with attachments) to make sure Spotlight indexes all your mail.

**Re-index your messages** Open Terminal (in /Applications/Utilities) and type this command, followed by Return: mdimport -r /System/Library/Spotlight/Mail.mdimporter This causes Spotlight to re-index all your Mail messages, leaving the rest of your Spotlight indexes (for other types of data) intact.

**Reset your Spotlight index** If the other Spotlight fixes don’t work, you might need to reset your entire Spotlight index, although rebuilding it will take quite a bit of time—many hours if you’ve got a large hard drive full of files. In Terminal, enter this command and then press Return: sudo mdutil -E / Enter your OS X account password when prompted. (Note that only an account with administrative access can use this command.)

**Re-download or rebuild** A final possibility, which again applies only to server-based accounts, is that the messages in one or more mailboxes weren’t downloaded correctly or completely in the first place. To fix this, first choose Mailbox -> Synchronize to make sure server-based accounts are updated. Give Mail some time to process—you can view Mail’s Activity window, via Window -> Activity, to monitor progress—and then try your search again.

If that doesn’t work, select each mailbox containing messages that aren’t being searched properly, and then choose Mailbox -> Rebuild. This erases the local copies of all the messages in that mailbox and forces Mail to download them again from the server. In some situations, this can take even longer than rebuilding your Spotlight index, but it may be the only way to fix certain mailbox problems.
