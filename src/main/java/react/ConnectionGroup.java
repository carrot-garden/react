//
// React - a library for functional-reactive-like programming in Java
// Copyright (c) 2011, Three Rings Design, Inc. - All rights reserved.
// http://github.com/threerings/react/blob/master/LICENSE

package react;

import java.util.HashSet;
import java.util.Set;

/**
 * Collects connections to allow mass operations on them.
 */
public class ConnectionGroup
{
    /**
     * Disconnects all connections in the group.
     */
    public void disconnect ()
    {
        for (Connection c : _connections) {
            c.disconnect();
        }
        _connections.clear();
    }

    /** Adds a connection to the group. */
    public Connection add (Connection c)
    {
        _connections.add(c);
        return c;
    }

    /** Removes a connection from the group while leaving its connected status unchanged. */
    public void remove (Connection c)
    {
        _connections.remove(c);
    }

    protected Set<Connection> _connections = new HashSet<Connection>();
}
