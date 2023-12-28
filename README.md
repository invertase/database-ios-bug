## Reproduce

1. Add `GoogleService-Info.plist` to this project.
2. Update Firebase Database rules to allow read/writes:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

3. Run `pod install` in the root of the project.
4. Run the app.
5. Add data to your database by pressing "Write data" button.
5. Press button "Get "organizations/0/data"" which will retrieve correct data. You will see this in the Xcode console:
```
Received data: (
    a,
    b,
    c,
    d,
    e,
    f,
    g,
    h
)
```
6. Press "Observe "organizations/0"" which will listen to the parent node of step 5 "Get "organizations/0/data"" button press.
7. Press button "Get "organizations/0/data"" again. Note that the response has changed to:
```
Received data: {
    city = Lyon;
    country = France;
    data =     (
        a,
        b,
        c,
        d,
        e,
        f,
        g,
        h
    );
    foo = bar;
    id = 0;
    name = "my organization";
}
```

The response changes after observing the parent nodes data.
