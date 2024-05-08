from dataclasses import dataclass, field
from typing import Dict, List, Tuple

from opendevin.controller.state.plan import Plan
from opendevin.events.action import (
    Action,
    MessageAction,
)
from opendevin.events.observation import (
    CmdOutputObservation,
    Observation,
)


@dataclass
class State:
    plan: Plan = Plan()
    iteration: int = 0
    # number of characters we have sent to and received from LLM so far for current task
    num_of_chars: int = 0
    background_commands_obs: List[CmdOutputObservation] = field(default_factory=list)
    history: List[Tuple[Action, Observation]] = field(default_factory=list)
    updated_info: List[Tuple[Action, Observation]] = field(default_factory=list)
    inputs: Dict = field(default_factory=dict)
    outputs: Dict = field(default_factory=dict)

    def get_current_user_intent(self):
        # TODO: this is used to understand the user's main goal, but it's possible
        # the latest message is an interruption. We should look for a space where
        # the agent goes to FINISHED, and then look for the next user message.
        for action, obs in reversed(self.history):
            if isinstance(action, MessageAction) and action.source == 'user':
                return action.content