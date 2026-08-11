"""Singly linked list — ownership practice (libft bonus territory)."""

@fieldwise_init
struct ListNode(Copyable, Movable):
    var value: Int
    var next_index: Int  # -1 = none; indices into a node arena

struct LinkedList(Movable):
    """Arena-backed linked list to practice graph-like structures in Mojo."""
    var nodes: List[ListNode]
    var head: Int

    def __init__(out self):
        self.nodes = List[ListNode]()
        self.head = -1

    def push_front(mut self, value: Int):
        var idx = len(self.nodes)
        self.nodes.append(ListNode(value, self.head))
        self.head = idx

    def push_back(mut self, value: Int):
        var idx = len(self.nodes)
        self.nodes.append(ListNode(value, -1))
        if self.head < 0:
            self.head = idx
            return
        var cur = self.head
        while self.nodes[cur].next_index >= 0:
            cur = self.nodes[cur].next_index
        self.nodes[cur].next_index = idx

    def to_list(self) -> List[Int]:
        var out = List[Int]()
        var cur = self.head
        while cur >= 0:
            out.append(self.nodes[cur].value)
            cur = self.nodes[cur].next_index
        return out^

    def length(self) -> Int:
        var n = 0
        var cur = self.head
        while cur >= 0:
            n += 1
            cur = self.nodes[cur].next_index
        return n
