package core;

import config.FluxiGenerator;
import misc.CaseTransformer;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class FluxiCLI
{
    public static void main(String[] args) throws IOException {
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(System.in));
        String line;

        while ( (line = bufferedReader.readLine()) != null )
        {
            parseCommand(line);
        }
    }

    public static void parseCommand(String command)
    {
        System.out.println("READ LINE: "+command);
        // fluxi make model
        if ( command.startsWith("fluxi make model") )
        {
            try {
                FluxiBag fluxiBag = parseMakeModelCommand(command.substring("fluxi make model ".length()));
                FluxiGenerator.generateFluxi(fluxiBag);
            } catch(Exception ex)
            {
                throw new IllegalArgumentException("Illegal Fluxi Command: "+ex.toString());
            }
        } else if ( command.startsWith("fluxi make initializer") )
        {
            try {
                FluxiGenerator.generateInitializer(parseMakeInitializerCommand(command.substring("fluxi make initializer ".length())));
            } catch(Exception ex)
            {
                throw new IllegalArgumentException("Illegal Fluxi Initializer Command: "+ex.toString());
            }
        }
    }
    //fluxi make model Person name:string age:integer
    private static FluxiBag parseMakeModelCommand(String command)
    {
        FluxiBag model = new FluxiBag();
        String[] atoms = command.split(" ");
        model.name = CaseTransformer.firstLetterBig(atoms[0]);
        model.params = new FluxiParam[atoms.length-1];
        for(int i = 1; i < atoms.length; i++)
        {
            String[] atom_atoms = atoms[i].split(":");
            model.params[i-1] = new FluxiParam(FluxiType.parse(atom_atoms[1]),atom_atoms[0]);
        }
        return  model;
    }

    private static FluxiBag parseMakeInitializerCommand(String command)
    {
        FluxiBag model = new FluxiBag();
        String[] atoms = command.split(" ");
        model.name = CaseTransformer.firstLetterBig(atoms[0]);
        model.params = new FluxiParam[atoms.length-1];
        for(int i = 1; i < atoms.length; i++)
        {
            String[] atom_atoms = atoms[i].split(":");
            model.params[i-1] = new FluxiParam(FluxiType.parse(atom_atoms[1]),atom_atoms[0]);
        }
        return model;
    }
}
