package config;

import core.FluxiBag;
import core.FluxiTemplateTransformer;
import generators.flutter.flutter_migration_injection_generator;
import generators.flutter.flutter_model_injection_generator;
import generators.flutter.flutter_model_repo_injection_generator;
import generators.flutter.flutter_model_tele_state_injection_generator;
import generators.phoenix.phoenix_channel_injection_generator;
import generators.phoenix.phoenix_migration_injection_generator;
import generators.phoenix.phoenix_model_injection_generator;
import generators.phoenix.phoenix_repo_injection_generator;
import generators.plain_generator;

import java.util.ArrayList;

public class FluxiGenerator
{
    public static void generateFluxi(FluxiBag fluxiBag)
    {
        fluxiBag.addUUID();
        String phoenixModel = FluxiTemplateTransformer.transformTemplate(
        "phoenix/phoenix_model_template.fluxi",
                new phoenix_model_injection_generator(fluxiBag),
                fluxiBag,
                "phoenix",
                ".ex"
        );
        FluxiTemplateTransformer.transformTemplate(
                "phoenix/phoenix_migration_template.fluxi",
                new phoenix_migration_injection_generator(fluxiBag),
                fluxiBag,
                "phoenix",
                "_migration.ex"
        );
        FluxiTemplateTransformer.transformTemplate(
                "phoenix/phoenix_repo_template.fluxi",
                new phoenix_repo_injection_generator(fluxiBag),
                fluxiBag,
                "phoenix",
                "_repo.ex"
        );
        FluxiTemplateTransformer.transformTemplate(
                "phoenix/phoenix_channel_template.fluxi",
                new phoenix_channel_injection_generator(fluxiBag),
                fluxiBag,
                "phoenix",
                "_channel.ex"
        );
        FluxiTemplateTransformer.transformTemplate(
                "flutter/flutter_model_template.fluxi",
                new flutter_model_injection_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_model.dart"
        );

        FluxiTemplateTransformer.transformTemplate(
                "flutter/flutter_migration_template.fluxi",
                new flutter_migration_injection_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_migration.dart"
        );
        FluxiTemplateTransformer.transformTemplate(
                "flutter/flutter_tele_state_template.fluxi",
                new flutter_model_tele_state_injection_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_tele_state.dart"
        );
        FluxiTemplateTransformer.transformTemplate(
                "flutter/flutter_repo_template.fluxi",
                new flutter_model_repo_injection_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_repo.dart"
        );
    }

    public static void generateInitializer(FluxiBag fluxiBag)
    {
        FluxiTemplateTransformer.transformTemplate(
                "flutter/flutter_project_initializer.fluxi",
                new plain_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_flutter_setup.sh"
        );
        FluxiTemplateTransformer.transformTemplate(
                "flutter/fluxi_socket_instance.fluxi",
                new plain_generator(fluxiBag),
                fluxiBag,
                "flutter",
                "_socket_instance.dart"
        );
        FluxiTemplateTransformer.transformTemplate(
                "phoenix/phoenix_project_initializer.fluxi",
                new plain_generator(fluxiBag),
                fluxiBag,
                "phoenix",
                "_phoenix_setup.sh"
        );

    }
}