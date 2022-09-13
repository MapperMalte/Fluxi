package core;

import java.lang.reflect.Method;

public class FluxiReflection
{
    Method method;
    String paramName;

    FluxiReflection(Method method, String paramName)
    {
        this.method = method;
        this.paramName = paramName;
    }
}