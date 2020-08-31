import { install } from 'intrustd';

install({ permissions: [ "intrustd+perm://terminal.intrustd.com/access" ],
          appName: 'terminal.intrustd.com',
          captureWebSocketsFor: [ 'terminal.intrustd.com', 'localhost:6867' ],
          intrustdByDefault: true })

console.log("Window.websocket is now ", WebSocket)

import 'ttyd/src/index.tsx';
