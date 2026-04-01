# Chat: P1 INC0042069 - KangarooBank Mobile App displaying negative balances as positive
---

## Chat Members
- Bazza
- Brenda
- Callum
- Damo
- Fiona
- Gavin
- Hayley
- Jono
- Karen
- Lachlan (known as Lachy)
- Megan (known as Megs)
- Neville
- Priya
- Rhonda
- Shane
- Tanya
- Wayne

## Chat Content
Tuesday 6 May 2026 9:03AM AEST

Hi Team,

Raising a P1. KangarooBank Mobile App is showing negative balances as positive numbers for all customers. We have customers celebrating paying off their mortgage when they actually owe $450,000. Social media is going nuts.

Callum Reid (AU) changed the group name to P1 INC0042069 - KangarooBank Mobile Negative Balance Display.

Tuesday 6 May 2026 9:06AM AEST

Morning all. We are looking into it now.

Damo Fitzpatrick (AU) added Priya Sharma (AU) and Lachlan O'Brien (AU) to the chat and shared all chat history.

Tuesday 6 May 2026 9:08AM AEST

Just to confirm the scope - this is ALL customers or just a subset?

Tuesday 6 May 2026 9:10AM AEST

All of them Priya. Every single one. My mum just rang me to say she's going to Bali because her credit card is showing she's $12,000 in the black.

Tuesday 6 May 2026 9:11AM AEST

Please tell your mum not to book anything yet

Too late. She's already at the airport.

Callum Reid (AU)
Brilliant. Ok, which release went out last night?

Tuesday 6 May 2026 9:14AM AEST

v4.7.2 went to prod at 11:45PM AEST last night. It was the currency formatting update for the new multi-currency feature.

Tuesday 6 May 2026 9:21AM AEST

Found it. Someone changed `Math.abs()` on the balance display thinking it was fixing a formatting bug. It's literally taking the absolute value of every balance. Every negative number is now positive.

Damo Fitzpatrick (AU)
Found it. Someone changed `Math.abs()` on the balance display thinking it was fixing a formatting bug.
You're joking. Who approved that PR?

Wayne Bucket (AU) added Gavin Thornton (AU) to the chat and shared all chat history.

Tuesday 6 May 2026 9:23AM AEST

Gavin Thornton (AU) - FYI you approved the PR for the currency formatting change. Can you jump on this please.

Tuesday 6 May 2026 9:25AM AEST

Look I saw "fix negative display issue" in the PR title and the tests were green. How was I supposed to know they meant they were REMOVING the negative sign, not fixing a rendering bug?

Tuesday 6 May 2026 9:26AM AEST

The unit test literally says `assertEquals(450000, formatBalance(-450000))` and you thought that was CORRECT?

Tuesday 6 May 2026 9:27AM AEST

In my defence it was 4:30 on a Friday

Tanya Wells (AU) added Karen Mitchell (AU) to the chat and shared all chat history.

Tuesday 6 May 2026 9:29AM AEST

Karen Mitchell (AU) - Comms are asking how many customers are affected. The ABC has picked it up.

Fiona Xu (AU)
Karen Mitchell (AU) - Comms are asking how many customers are affected. The ABC has picked it up.
2.3 million active mobile app users. All of them are seeing incorrect balances.

Tuesday 6 May 2026 9:31AM AEST

Oh good lord. What's the hashtag?

Tuesday 6 May 2026 9:32AM AEST

#KangarooBank is trending. Also #FreeMoney and #ThankYouKangaroo. Someone's made a TikTok already with 400k views.

Brenda Hooper (AU) added Shane Gallagher (AU) and Rhonda Park (AU) to the chat and shared all chat history.

Tuesday 6 May 2026 9:34AM AEST

Shane Gallagher (AU) / Rhonda Park (AU) - Contact centre update: call volumes up 3,400%. Queue time is 4 hours. Customers are calling to confirm they've paid off their home loan. One bloke in Toowoomba is at a Porsche dealership trying to get finance approved based on his app screenshot.

Shane Gallagher (AU)
One bloke in Toowoomba is at a Porsche dealership trying to get finance approved based on his app screenshot.
Can we please focus on the fix. Damo how long to rollback?

Tuesday 6 May 2026 9:37AM AEST

Rollback is ready. Deploying v4.7.1 now. ETA 15 minutes.

Tuesday 6 May 2026 9:38AM AEST

Can we put a banner on the app in the meantime? Something like "Balances may be temporarily incorrect"

Neville Bruce (AU)
Can we put a banner on the app in the meantime?
Already on it. Legal is reviewing the wording now.

Tuesday 6 May 2026 9:41AM AEST

Legal came back. They don't want us to say "incorrect". They want us to say "balances are currently undergoing a scheduled display refresh"

Tuesday 6 May 2026 9:42AM AEST

A SCHEDULED DISPLAY REFRESH? We turned everyone's debt into savings and we're calling it a SCHEDULED DISPLAY REFRESH?

Megan Porter (AU)
A SCHEDULED DISPLAY REFRESH?
I don't write the copy Karen, I just pass it along.

Tuesday 6 May 2026 9:51AM AEST

Rollback deployed. Balances should be correcting now. Can everyone check?

Tuesday 6 May 2026 9:53AM AEST

Confirmed. My test account is showing -$2,450.00 again as expected.

Priya Sharma (AU)
Confirmed. My test account is showing -$2,450.00 again as expected.
Same here. Negative balances are back to negative.

Tuesday 6 May 2026 9:55AM AEST

Twitter is now full of people saying we've stolen their money because their balance "went down". We can't win.

Jono Mackenzie (AU) added Hayley Chen (AU) to the chat and shared all chat history.

Tuesday 6 May 2026 9:58AM AEST

Hayley Chen (AU) - Compliance here. APRA are on the phone. They want to know how a `Math.abs()` call made it through our change management process.

Tuesday 6 May 2026 9:59AM AEST

Tell APRA our change management process is very thorough and this was an isolated incident

Tuesday 6 May 2026 10:00AM AEST

Gavin it literally passed through your review with a comment that said "looks good mate, chuck it in" at 4:47PM on a Friday

Bazza Wentworth (AU)
Tell APRA our change management process is very thorough
I just want to flag that three customers have already applied for loans at other banks using screenshots of their KangarooBank "positive" balances as proof of savings. Fraud team is across it.

Tuesday 6 May 2026 10:03AM AEST

Update from contact centre: A customer in Cairns withdrew $15,000 cash this morning before balances were corrected. She said she "wanted to get it out before the bank realised their mistake." She's now at the airport.

Tuesday 6 May 2026 10:05AM AEST

Can we get a timeline for the PIR? APRA want it by COB Friday.

Tuesday 6 May 2026 10:06AM AEST

Scheduling PIR for Thursday 8 May, 10AM AEST. All team leads please block your calendars.

Damo Fitzpatrick (AU)
Rollback deployed. Balances should be correcting now.
Can we confirm the fix is fully propagated? CDN cache?

Tuesday 6 May 2026 10:08AM AEST

Good call. CDN cache TTL is 30 minutes. Some users might still see old values until 10:15AM AEST.

Tuesday 6 May 2026 10:14AM AEST

Confirmed all balances are displaying correctly now. Datadog monitors are green.

Tuesday 6 May 2026 10:22AM AEST

Final count from contact centre: 47,000 calls received. 312 customers attempted transactions based on incorrect balances. 4 car dealership visits. 1 customer put a deposit on a boat in Airlie Beach.

Tuesday 6 May 2026 10:25AM AEST

Can we resolve this incident?

Tuesday 6 May 2026 10:26AM AEST

Yes but I want the following actions logged:
1. Code review process update - no more Friday afternoon approvals
2. Unit test review - tests should not pass when they assert that negative numbers equal positive numbers
3. Balance display changes require sign-off from Finance team
4. Gavin to complete mandatory code review training

Gavin Thornton (AU)
In my defence it was 4:30 on a Friday
Noted, Callum. I will also be updating my LinkedIn to "Available for new opportunities."

Tuesday 6 May 2026 10:28AM AEST

Let's not be hasty Gavin. But maybe no more Friday deploys yeah?

Shane Gallagher (AU)
1 customer put a deposit on a boat in Airlie Beach.
Can someone please follow up on the boat situation? Legal wants to know if we're liable.

Tuesday 6 May 2026 10:31AM AEST

Resolving INC0042069. PIR scheduled for Thursday 8 May. All action items logged.

Tuesday 6 May 2026 10:33AM AEST

Thanks everyone. Great work getting this sorted quickly. And Gavin - we've all been there mate.

Tuesday 6 May 2026 10:34AM AEST

Not like this we haven't.
