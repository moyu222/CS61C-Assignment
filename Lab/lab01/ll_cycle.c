#include <stddef.h>
#include "ll_cycle.h"

int ll_has_cycle(node *head) {
    /* your code here */
    if (head == NULL)
    {
        return 0;
    }
    
    node *t = head;
    node *h = head;

    while (h != NULL)  
    {
        if (h->next == NULL)
        {
            return 0;
        }
        
        h = h->next->next;
        t = t->next;
        if (t == h)
        {
            return 1;
        }
        
    }
    return 0;
}