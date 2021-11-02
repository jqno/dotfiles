from datetime import datetime
from libqtile.widget import base


class AnalogClock(base.InLoopPollText):

    hours = ['🕛', '🕐', '🕑', '🕒', '🕓', '🕔', '🕕', '🕖', '🕗', '🕘', '🕙', '🕚']
    halfs = ['🕧', '🕜', '🕝', '🕞', '🕟', '🕠', '🕡', '🕢', '🕣', '🕤', '🕥', '🕦']

    def __init__(self, **config):
        base.InLoopPollText.__init__(self, **config)
        self.expanded = False
        self.update_interval = 20
        self.mouse_callbacks = {'Button1': self.toggle_expansion}

    def toggle_expansion(self):
        self.expanded = not self.expanded
        self.tick()
        if self.expanded:
            self.timeout_add(self.update_interval, self.unexpand)

    def unexpand(self):
        self.expanded = False
        self.tick()

    def poll(self):
        now = datetime.now()
        emoji = self.emoji(now)
        if self.expanded:
            return emoji + ' ' + self.full_time(now)
        else:
            return emoji

    def emoji(self, now):
        hour = now.hour % 12
        if now.minute < 30:
            return self.hours[hour]
        else:
            return self.halfs[hour]

    def full_time(self, now):
        return now.strftime('%-d %B %Y | %H:%M')
